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

    ColumnLayout {
        id: batteryColumn
        anchors.centerIn: parent
        spacing: 0

        MaterialSymbol {
            Layout.alignment: Qt.AlignHCenter
            fill: 0
            text: {
                const level = root.percentage;
                if (root.isCharging) {
                    if (level >= 0.9) return "battery_charging_full";
                    if (level >= 0.8) return "battery_charging_90";
                    if (level >= 0.6) return "battery_charging_80";
                    if (level >= 0.5) return "battery_charging_60";
                    if (level >= 0.3) return "battery_charging_50";
                    if (level >= 0.2) return "battery_charging_30";
                    return "battery_charging_20";
                } else {
                    if (level >= 0.95) return "battery_full";
                    if (level >= 0.85) return "battery_6_bar";
                    if (level >= 0.7) return "battery_5_bar";
                    if (level >= 0.55) return "battery_4_bar";
                    if (level >= 0.4) return "battery_3_bar";
                    if (level >= 0.25) return "battery_2_bar";
                    if (level >= 0.1) return "battery_1_bar";
                    return "battery_0_bar";
                }
            }
            iconSize: Appearance.font.pixelSize.larger
            color: root.isLow ? Appearance.m3colors.m3error : Appearance.colors.colOnLayer0
            animateChange: true
        }
    }

    Bar.BatteryPopup {
        id: batteryPopup
        hoverTarget: root
    }
}
