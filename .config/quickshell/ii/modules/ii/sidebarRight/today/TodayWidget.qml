import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

Item {
    id: root
    property var selectedEvent: null

    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Escape && root.selectedEvent) {
            root.selectedEvent = null;
            event.accepted = true;
        }
    }

    // Header
    RowLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 4
        anchors.rightMargin: 4
        z: 1

        MaterialSymbol {
            text: "event"
            iconSize: Appearance.font.pixelSize.large
            color: Appearance.colors.colOnLayer1
        }
        StyledText {
            text: Translation.tr("Events")
            font.pixelSize: Appearance.font.pixelSize.normal
            font.bold: true
            color: Appearance.colors.colOnLayer1
        }
        Item { Layout.fillWidth: true }
        RippleButton {
            implicitWidth: 24
            implicitHeight: 24
            buttonRadius: 12
            onClicked: CalendarEvents.refresh()
            contentItem: MaterialSymbol {
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                text: "refresh"
                iconSize: Appearance.font.pixelSize.normal
                color: Appearance.colors.colOnLayer1
            }
        }
    }

    // Scrollable event list grouped by date
    Flickable {
        anchors.fill: parent
        anchors.topMargin: 28
        contentHeight: eventsColumn.implicitHeight
        clip: true
        boundsBehavior: Flickable.StopAtBounds

        ColumnLayout {
            id: eventsColumn
            width: parent.width
            spacing: 4

            // Loading state
            StyledText {
                visible: CalendarEvents.loading
                Layout.fillWidth: true
                Layout.leftMargin: 4
                text: Translation.tr("Loading...")
                font.pixelSize: Appearance.font.pixelSize.small
                color: Appearance.m3colors.m3outline
            }

            // Empty state
            StyledText {
                visible: CalendarEvents.events.length === 0 && !CalendarEvents.loading
                Layout.fillWidth: true
                Layout.leftMargin: 4
                text: Translation.tr("No events")
                font.pixelSize: Appearance.font.pixelSize.small
                color: Appearance.m3colors.m3outline
            }

            // Date groups
            Repeater {
                model: ScriptModel {
                    values: CalendarEvents.groupedByDate
                }
                delegate: ColumnLayout {
                    id: dateGroup
                    required property var modelData
                    required property int index
                    Layout.fillWidth: true
                    spacing: 4

                    // Date header (skip for first group if it's today - the main header covers it)
                    StyledText {
                        visible: dateGroup.modelData.date !== CalendarEvents.todayDate
                        Layout.fillWidth: true
                        Layout.leftMargin: 4
                        Layout.topMargin: 6
                        text: dateGroup.modelData.label
                        font.pixelSize: Appearance.font.pixelSize.small
                        font.bold: true
                        color: Appearance.m3colors.m3outline
                    }

                    // Events in this date group
                    Repeater {
                        model: ScriptModel {
                            values: dateGroup.modelData.events
                        }
                        delegate: RippleButton {
                            id: eventItem
                            required property var modelData
                            readonly property bool isToday: eventItem.modelData.date === CalendarEvents.todayDate
                            readonly property bool passed: isToday
                                && !modelData.allDay
                                && modelData.endTime24 !== ""
                                && modelData.endTime24 <= CalendarEvents.currentTime24
                            Layout.fillWidth: true
                            Layout.leftMargin: 2
                            Layout.rightMargin: 2
                            implicitHeight: eventRow.implicitHeight + 8
                            opacity: eventItem.passed ? 0.5 : 1.0
                            colBackground: Appearance.colors.colLayer2
                            colBackgroundHover: Appearance.colors.colLayer2Hover
                            buttonRadius: Appearance.rounding.small
                            onClicked: root.selectedEvent = eventItem.modelData

                            RowLayout {
                                id: eventRow
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin: 8
                                anchors.rightMargin: 8
                                spacing: 8

                                Rectangle {
                                    width: 3
                                    height: eventTitle.implicitHeight
                                    radius: 1.5
                                    color: eventItem.modelData.meetLink !== ""
                                        ? Appearance.colors.colPrimary
                                        : eventItem.modelData.source === "icloud"
                                            ? "#FF9500"
                                            : Appearance.m3colors.m3outline
                                }

                                MaterialSymbol {
                                    visible: eventItem.modelData.meetLink !== ""
                                    text: "video_call"
                                    iconSize: Appearance.font.pixelSize.small
                                    color: Appearance.colors.colPrimary
                                }

                                StyledText {
                                    visible: !eventItem.modelData.allDay
                                    text: eventItem.modelData.startTime
                                    font.pixelSize: Appearance.font.pixelSize.small
                                    font.strikeout: eventItem.passed
                                    color: Appearance.m3colors.m3outline
                                    Layout.preferredWidth: visible ? implicitWidth : 0
                                }
                                StyledText {
                                    visible: eventItem.modelData.allDay
                                    text: Translation.tr("All day")
                                    font.pixelSize: Appearance.font.pixelSize.small
                                    color: Appearance.m3colors.m3outline
                                    Layout.preferredWidth: visible ? implicitWidth : 0
                                }
                                StyledText {
                                    id: eventTitle
                                    text: eventItem.modelData.title
                                    font.pixelSize: Appearance.font.pixelSize.small
                                    font.strikeout: eventItem.passed
                                    color: Appearance.colors.colOnLayer1
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // --- Event Detail Popup ---
    Item {
        anchors.fill: parent
        z: 9999

        visible: opacity > 0
        opacity: root.selectedEvent ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: Appearance.animation.elementMoveFast.duration
                easing.type: Appearance.animation.elementMoveFast.type
                easing.bezierCurve: Appearance.animation.elementMoveFast.bezierCurve
            }
        }

        // Scrim
        Rectangle {
            anchors.fill: parent
            radius: Appearance.rounding.small
            color: Appearance.colors.colScrim
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                preventStealing: true
                propagateComposedEvents: false
                onClicked: root.selectedEvent = null
            }
        }

        // Popup card
        Rectangle {
            id: eventPopup
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            implicitHeight: popupContent.implicitHeight
            color: Appearance.m3colors.m3surfaceContainerHigh
            radius: Appearance.rounding.normal

            ColumnLayout {
                id: popupContent
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 8

                // Title
                StyledText {
                    Layout.topMargin: 16
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    Layout.fillWidth: true
                    text: root.selectedEvent ? root.selectedEvent.title : ""
                    font.pixelSize: Appearance.font.pixelSize.larger
                    font.bold: true
                    color: Appearance.m3colors.m3onSurface
                    wrapMode: Text.Wrap
                }

                // Time
                RowLayout {
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    spacing: 6

                    MaterialSymbol {
                        text: "schedule"
                        iconSize: Appearance.font.pixelSize.normal
                        color: Appearance.m3colors.m3onSurfaceVariant
                    }
                    StyledText {
                        text: {
                            if (!root.selectedEvent) return "";
                            if (root.selectedEvent.allDay) return Translation.tr("All day");
                            return root.selectedEvent.startTime + " - " + root.selectedEvent.endTime;
                        }
                        font.pixelSize: Appearance.font.pixelSize.normal
                        color: Appearance.m3colors.m3onSurfaceVariant
                    }
                }

                // Location (if any)
                RowLayout {
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    spacing: 6
                    visible: root.selectedEvent && root.selectedEvent.location !== ""

                    MaterialSymbol {
                        text: "location_on"
                        iconSize: Appearance.font.pixelSize.normal
                        color: Appearance.m3colors.m3onSurfaceVariant
                    }
                    StyledText {
                        text: root.selectedEvent ? root.selectedEvent.location : ""
                        font.pixelSize: Appearance.font.pixelSize.normal
                        color: Appearance.m3colors.m3onSurfaceVariant
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }
                }

                // Description (if any)
                StyledText {
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    Layout.fillWidth: true
                    visible: root.selectedEvent && root.selectedEvent.description !== ""
                    text: root.selectedEvent ? root.selectedEvent.description : ""
                    font.pixelSize: Appearance.font.pixelSize.small
                    color: Appearance.m3colors.m3onSurfaceVariant
                    wrapMode: Text.Wrap
                    maximumLineCount: 5
                    elide: Text.ElideRight
                }

                // Action buttons
                RowLayout {
                    Layout.bottomMargin: 16
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    Layout.alignment: Qt.AlignRight
                    spacing: 8

                    // Google Meet button
                    DialogButton {
                        visible: root.selectedEvent && root.selectedEvent.meetLink !== ""
                        buttonText: "Join Meet"
                        colEnabled: Appearance.m3colors.m3onPrimary
                        colBackground: Appearance.colors.colPrimary
                        colBackgroundHover: Appearance.colors.colPrimaryHover
                        onClicked: {
                            Qt.openUrlExternally(root.selectedEvent.meetLink);
                            root.selectedEvent = null;
                        }
                    }

                    // Open in Google Calendar
                    DialogButton {
                        visible: root.selectedEvent && root.selectedEvent.htmlLink !== ""
                        buttonText: Translation.tr("Open in Calendar")
                        onClicked: {
                            Qt.openUrlExternally(root.selectedEvent.htmlLink);
                            root.selectedEvent = null;
                        }
                    }

                    DialogButton {
                        buttonText: Translation.tr("Close")
                        onClicked: root.selectedEvent = null
                    }
                }
            }
        }
    }
}
