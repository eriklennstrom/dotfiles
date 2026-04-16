#!/usr/bin/env python3
"""Fetch today's events from iCloud CalDAV and output as TSV."""

import re
import subprocess
import sys
from datetime import datetime, timedelta, timezone

import caldav
import icalendar


def get_credentials():
    password = subprocess.check_output(
        ["secret-tool", "lookup", "service", "icloud-calendar"],
        text=True,
    ).strip()
    account = subprocess.check_output(
        ["secret-tool", "search", "service", "icloud-calendar"],
        capture_output=False,
        text=True,
        stderr=subprocess.STDOUT,
    )
    email = None
    for line in account.splitlines():
        if "attribute.account" in line:
            email = line.split("=", 1)[1].strip()
            break
    if not email or not password:
        print("error: missing icloud credentials", file=sys.stderr)
        sys.exit(1)
    return email, password


def fetch_events():
    email, password = get_credentials()
    url = "https://caldav.icloud.com/"

    client = caldav.DAVClient(url=url, username=email, password=password)
    principal = client.principal()
    calendars = principal.calendars()

    today = datetime.now(timezone.utc).replace(hour=0, minute=0, second=0, microsecond=0)
    tomorrow = today + timedelta(days=2)

    events = []
    for cal in calendars:
        try:
            results = cal.search(start=today, end=tomorrow, event=True, expand=True)
        except Exception:
            continue
        for event in results:
            try:
                ical = icalendar.Calendar.from_ical(event.data)
            except Exception:
                continue
            for component in ical.walk():
                if component.name != "VEVENT":
                    continue

                summary = str(component.get("SUMMARY", ""))
                location = str(component.get("LOCATION", ""))
                description = str(component.get("DESCRIPTION", ""))
                dtstart = component.get("DTSTART")
                dtend = component.get("DTEND")

                if dtstart is None:
                    continue

                start_dt = dtstart.dt
                end_dt = dtend.dt if dtend else None

                all_day = not isinstance(start_dt, datetime)

                if all_day:
                    start_time = ""
                    end_time = ""
                    start_date = start_dt.strftime("%Y-%m-%d")
                    end_date = end_dt.strftime("%Y-%m-%d") if end_dt else ""
                else:
                    local_start = start_dt.astimezone()
                    start_date = local_start.strftime("%Y-%m-%d")
                    start_time = local_start.strftime("%H:%M")
                    if end_dt:
                        local_end = end_dt.astimezone()
                        end_date = local_end.strftime("%Y-%m-%d")
                        end_time = local_end.strftime("%H:%M")
                    else:
                        end_date = ""
                        end_time = ""

                # Extract conference/meet links from description
                meet_link = ""
                if description:
                    urls = re.findall(r'https?://[^\s<>"\']+', description)
                    for u in urls:
                        if "meet.google.com" in u or "zoom.us" in u or "teams.microsoft.com" in u or "facetime.apple.com" in u:
                            meet_link = u
                            break

                # Clean description
                clean_desc = description.replace("\n", " ").replace("\t", " ").strip()

                events.append({
                    "start_date": start_date,
                    "start_time": start_time,
                    "end_date": end_date,
                    "end_time": end_time,
                    "title": summary,
                    "location": location,
                    "description": clean_desc,
                    "meet_link": meet_link,
                })

    # Sort by all-day first, then by start_time
    events.sort(key=lambda e: (0 if e["start_time"] == "" else 1, e["start_time"]))

    # Output TSV
    print("start_date\tstart_time\tend_date\tend_time\ttitle\tlocation\tdescription\tmeet_link")
    for e in events:
        print(
            f"{e['start_date']}\t{e['start_time']}\t{e['end_date']}\t{e['end_time']}\t"
            f"{e['title']}\t{e['location']}\t{e['description']}\t{e['meet_link']}"
        )


if __name__ == "__main__":
    fetch_events()
