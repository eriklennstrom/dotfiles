import qs.modules.common
import qs.modules.common.widgets
import qs.services
import QtQuick
import QtQuick.Layouts
import qs.modules.ii.bar as Bar

MouseArea {
    id: root
    property bool borderless: Config.options.bar.borderless
    readonly property var chargeState: Battery.chargeState
    readonly property bool isCharging: Battery.isCharging
    readonly property bool isPluggedIn: Battery.isPluggedIn
    readonly property real percentage: Battery.percentage
    readonly property bool isLow: percentage <= Config.options.battery.low / 100

    implicitHeight: batteryColumn.implicitHeight
    implicitWidth: batteryColumn.implicitWidth
    hoverEnabled: !Config.options.bar.tooltips.clickToShow

    // Charging animation: cycle through levels above current
    property int chargeAnimLevel: 0
    Timer {
        id: chargeAnimTimer
        interval: 700
        repeat: true
        running: root.isCharging && root.percentage < 1.0
        onTriggered: {
            root.chargeAnimLevel = (root.chargeAnimLevel + 1) % 4;
        }
        onRunningChanged: {
            if (!running) root.chargeAnimLevel = 0;
        }
    }

    // macOS-style battery levels using battery_*_bar icons
    readonly property var dischargingIcons: [
        "battery_0_bar",   // 0-6%
        "battery_1_bar",   // 7-20%
        "battery_2_bar",   // 21-34%
        "battery_3_bar",   // 35-49%
        "battery_4_bar",   // 50-64%
        "battery_5_bar",   // 65-79%
        "battery_6_bar",   // 80-94%
        "battery_full"     // 95-100%
    ]

    readonly property var chargingIcons: [
        "battery_charging_20",  // step 0
        "battery_charging_30",  // step 1
        "battery_charging_50",  // step 2
        "battery_charging_60",  // step 3
        "battery_charging_80",  // step 4
        "battery_charging_90",  // step 5
        "battery_charging_full" // step 6
    ]

    function getBatteryStep(pct) {
        if (pct >= 0.95) return 7;
        if (pct >= 0.80) return 6;
        if (pct >= 0.65) return 5;
        if (pct >= 0.50) return 4;
        if (pct >= 0.35) return 3;
        if (pct >= 0.21) return 2;
        if (pct >= 0.07) return 1;
        return 0;
    }

    function getDisplayIcon() {
        const pct = root.percentage;

        if (pct >= 1.0) return root.isCharging ? "battery_charging_full" : "battery_full";

        if (root.isCharging) {
            const baseStep = getBatteryStep(pct);
            // Map 0-7 battery step to 0-6 charging icon index
            const baseChargeIdx = Math.min(Math.floor(baseStep * 6 / 7), 6);
            const animIdx = Math.min(baseChargeIdx + 1 + root.chargeAnimLevel, 6);
            return root.chargingIcons[animIdx];
        }

        return root.dischargingIcons[getBatteryStep(pct)];
    }

    ColumnLayout {
        id: batteryColumn
        anchors.centerIn: parent
        spacing: 0

        MaterialSymbol {
            Layout.alignment: Qt.AlignHCenter
            fill: 1
            text: root.getDisplayIcon()
            iconSize: 20
            color: root.isLow ? Appearance.m3colors.m3error : Appearance.colors.colOnLayer0
            animateChange: false

            Behavior on text {
                enabled: !root.isCharging
                PropertyAnimation {
                    duration: 300
                }
            }
        }
    }

    Bar.BatteryPopup {
        id: batteryPopup
        hoverTarget: root
    }
}
