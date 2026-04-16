pragma Singleton
pragma ComponentBehavior: Bound

import qs.modules.common
import qs.services
import Quickshell
import Quickshell.Io
import QtQuick

/**
 * Fetches calendar events from Google Calendar (gcalcli) and iCloud (CalDAV).
 * events: flat sorted list of all events with a `date` field (YYYY-MM-DD).
 * groupedByDate: array of { date, label, events[] } for display.
 */
Singleton {
    id: root
    property var events: []
    property var groupedByDate: []
    property bool loading: false
    property string currentTime24: Qt.locale().toString(DateTime.clock.date, "HH:mm")
    property string todayDate: Qt.locale().toString(DateTime.clock.date, "yyyy-MM-dd")

    property var _googleEvents: []
    property var _icloudEvents: []
    property int _pendingSources: 0
    property var _notifiedEvents: ({}) // Track which events we already notified for

    readonly property int refreshIntervalMs: 10 * 60 * 1000
    readonly property int reminderMinutes: 5

    function refresh() {
        root.loading = true;
        root._pendingSources = 1;
        googleProcess.running = true;
        // Only run iCloud if the script exists
        if (FileUtils.exists(Directories.scriptPath + "/calendar/icloud_events.py")) {
            root._pendingSources = 2;
            icloudProcess.running = true;
        }
    }

    // Convert 12h "1:30pm" or 24h "13:30" to "HH:MM" for comparison
    function _to24h(t) {
        if (!t || t.trim() === "") return "";
        // Already 24h format (HH:MM)
        if (/^\d{1,2}:\d{2}$/.test(t)) return t.padStart(5, "0");
        // 12h format (h:MMam/pm)
        const m = t.match(/^(\d{1,2}):(\d{2})(am|pm)$/i);
        if (!m) return t;
        let h = parseInt(m[1]);
        const min = m[2];
        const ampm = m[3].toLowerCase();
        if (ampm === "pm" && h !== 12) h += 12;
        if (ampm === "am" && h === 12) h = 0;
        return String(h).padStart(2, "0") + ":" + min;
    }

    function _sourceFinished() {
        root._pendingSources--;
        if (root._pendingSources <= 0) {
            root.loading = false;
            const merged = root._googleEvents.concat(root._icloudEvents);
            // Sort by date, then all-day first, then by start time
            merged.sort(function(a, b) {
                if (a.date < b.date) return -1;
                if (a.date > b.date) return 1;
                if (a.allDay !== b.allDay) return a.allDay ? -1 : 1;
                const at = a.startTime24 || "";
                const bt = b.startTime24 || "";
                if (at < bt) return -1;
                if (at > bt) return 1;
                return 0;
            });
            root.events = merged;

            // Group by date
            const groups = [];
            let currentDate = "";
            let currentGroup = null;
            for (let i = 0; i < merged.length; i++) {
                const ev = merged[i];
                if (ev.date !== currentDate) {
                    currentDate = ev.date;
                    currentGroup = {
                        date: currentDate,
                        label: _dateLabel(currentDate),
                        events: [],
                    };
                    groups.push(currentGroup);
                }
                currentGroup.events.push(ev);
            }
            root.groupedByDate = groups;
        }
    }

    function _dateLabel(dateStr) {
        const today = new Date();
        const d = new Date(dateStr + "T00:00:00");
        const diffDays = Math.round((d - new Date(today.getFullYear(), today.getMonth(), today.getDate())) / 86400000);
        if (diffDays === 0) return Translation.tr("Today");
        if (diffDays === 1) return Translation.tr("Tomorrow");
        return dateStr;
    }

    Component.onCompleted: {
        refresh();
    }

    Timer {
        interval: root.refreshIntervalMs
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    // Check every 30s if an event is ~5 min away
    Timer {
        interval: 30 * 1000
        running: true
        repeat: true
        onTriggered: root._checkReminders()
    }

    function _checkReminders() {
        const now = new Date();
        const todayStr = Qt.formatDate(now, "yyyy-MM-dd");

        for (let i = 0; i < root.events.length; i++) {
            const ev = root.events[i];
            if (ev.allDay || ev.date !== todayStr || !ev.startTime24) continue;

            const key = ev.date + "_" + ev.startTime24 + "_" + ev.title;
            if (root._notifiedEvents[key]) continue;

            const parts = ev.startTime24.split(":");
            const eventTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(),
                parseInt(parts[0]), parseInt(parts[1]), 0);
            const diffMs = eventTime.getTime() - now.getTime();
            const diffMin = diffMs / 60000;

            // Notify if between 0 and 5 minutes away
            if (diffMin > 0 && diffMin <= root.reminderMinutes) {
                root._notifiedEvents[key] = true;
                const timeLabel = ev.startTime || ev.startTime24;
                const body = ev.meetLink
                    ? timeLabel + (ev.location ? " · " + ev.location : "")
                    : timeLabel + (ev.location ? " · " + ev.location : "");
                root._notify(ev.title, body);
            }
        }
    }

    function _notify(title, body) {
        Quickshell.execDetached(["notify-send", "--urgency=normal",
            "--app-name=Calendar", "--icon=x-office-calendar", title, body]);
    }

    // Reset notified events at midnight
    onTodayDateChanged: {
        root._notifiedEvents = {};
    }

    // --- Google Calendar (gcalcli) ---
    Process {
        id: googleProcess
        command: ["bash", "-c", "gcalcli agenda \"$(date +%Y-%m-%d)\" \"$(date -d '+2 days' +%Y-%m-%d)\" --details all --tsv --nocolor 2>/dev/null"]
        stdout: SplitParser {
            onRead: (line) => {
                googleProcess._stdout += line + "\n";
            }
        }
        property string _stdout: ""

        onRunningChanged: {
            if (!running) {
                root._googleEvents = parseGoogleTsv(googleProcess._stdout);
                googleProcess._stdout = "";
                root._sourceFinished();
            }
        }

        function parseGoogleTsv(text) {
            const lines = text.trim().split("\n");
            if (lines.length < 2) return [];

            const result = [];
            for (let i = 1; i < lines.length; i++) {
                const cols = lines[i].split("\t");
                if (cols.length < 10) continue;

                const startDate = cols[1] || "";
                const startTime = cols[2];
                const endTime = cols[4];
                const htmlLink = cols[5] || "";
                const conferenceUri = cols[8] || "";
                const title = cols[9] || "";
                const location = cols[10] || "";
                const description = cols[11] || "";

                const allDay = !startTime || startTime.trim() === "";

                result.push({
                    date: startDate,
                    title: title,
                    startTime: allDay ? "" : startTime,
                    startTime24: allDay ? "" : root._to24h(startTime),
                    endTime: allDay ? "" : endTime,
                    endTime24: allDay ? "" : root._to24h(endTime),
                    allDay: allDay,
                    htmlLink: htmlLink,
                    meetLink: conferenceUri || "",
                    location: location,
                    description: stripHtml(description),
                    source: "google",
                });
            }
            return result;
        }

        function stripHtml(html) {
            return html.replace(/<[^>]*>/g, "").replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, "\"").replace(/&#39;/g, "'").trim();
        }
    }

    // --- iCloud Calendar (CalDAV) ---
    Process {
        id: icloudProcess
        command: ["python3", Directories.scriptPath + "/calendar/icloud_events.py"]
        stdout: SplitParser {
            onRead: (line) => {
                icloudProcess._stdout += line + "\n";
            }
        }
        property string _stdout: ""

        onRunningChanged: {
            if (!running) {
                root._icloudEvents = parseIcloudTsv(icloudProcess._stdout);
                icloudProcess._stdout = "";
                root._sourceFinished();
            }
        }

        function parseIcloudTsv(text) {
            const lines = text.trim().split("\n");
            if (lines.length < 2) return [];

            // Header: start_date start_time end_date end_time title location description meet_link
            const result = [];
            for (let i = 1; i < lines.length; i++) {
                const cols = lines[i].split("\t");
                if (cols.length < 5) continue;

                const startDate = cols[0] || "";
                const startTime = cols[1] || "";
                const endTime = cols[3] || "";
                const title = cols[4] || "";
                const location = cols[5] || "";
                const description = cols[6] || "";
                const meetLink = cols[7] || "";

                const allDay = startTime.trim() === "";

                result.push({
                    date: startDate,
                    title: title,
                    startTime: startTime,
                    startTime24: allDay ? "" : root._to24h(startTime),
                    endTime: endTime,
                    endTime24: allDay ? "" : root._to24h(endTime),
                    allDay: allDay,
                    htmlLink: "",
                    meetLink: meetLink,
                    location: location,
                    description: description,
                    source: "icloud",
                });
            }
            return result;
        }
    }
}
