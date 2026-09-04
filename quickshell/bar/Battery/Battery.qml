import QtQuick
import Quickshell
import Quickshell.Services.UPower

Rectangle {
  id: root

    property color iconColor: "#f7768e"
    property color iconHoverColor: "#87768e"
    property color textColor: "#000000"
    property color textBackground: "#ffffff"
    property color borderColor: "#7700bb"

    implicitHeight: 40
    implicitWidth: 20

    color: "transparent"

    //Don't show unless device is a Laptop
    visible: UPower.displayDevice.ready && UPower.displayDevice.isLaptopBattery


    function resolveBatteryState(state) {
      const percentage = UPower.displayDevice.percentage
      switch (state) {
        case UPowerDeviceState.FullyCharged:
          return resolveBatteryPercentage(percentage);
          break;
        case UPowerDeviceState.PendingCharge:
          return '󱧥';
          break;
        case UPowerDeviceState.Discharging:
          return resolveBatteryPercentage(percentage);
          break;
        case UPowerDeviceState.Unknown:
          return '󰂑';
          break;
        case UPowerDeviceState.Charging:
          return resolveBatteryChargingPercentage(percentage);
          break;
        case UPowerDeviceState.PendingDischarge:
          return '󱠴';
          break;
        case UPowerDeviceState.Empty:
          return "󰂎";
          break;
      }
    }


    function resolveBatteryPercentage(percentage) {
      percentage *= 100;
      const Battery = Object.freeze({
        P100: '󰁹',
        P90: '󰂂',
        P80: '󰂁',
        P70: '󰂀',
        P60: '󰁿',
        P50: '󰁾',
        P40: '󰁽',
        P30: '󰁼',
        P20: '󰁻',
        P10: '󰁺'
      });
      if (percentage >= 90) return Battery.P100
      if (percentage >= 80) return Battery.P90
      if (percentage >= 70) return Battery.P80
      if (percentage >= 60) return Battery.P70
      if (percentage >= 50) return Battery.P60
      if (percentage >= 40) return Battery.P50
      if (percentage >= 30) return Battery.P40
      if (percentage >= 20) return Battery.P30
      if (percentage >= 10) return Battery.P20

      return Battery.P10
    }

    function resolveBatteryChargingPercentage(percentage) {
      percentage *= 100;
      const Battery = Object.freeze({
        P100: '󰂅',
        P90: '󰂋',
        P80: '󰂊',
        P70: '󰢞',
        P60: '󰂉',
        P50: '󰢝',
        P40: '󰂈',
        P30: '󰂇',
        P20: '󰂆',
        P10: '󰢜'
      });
      if (percentage >= 90) return Battery.P100
      if (percentage >= 80) return Battery.P90
      if (percentage >= 70) return Battery.P80
      if (percentage >= 60) return Battery.P70
      if (percentage >= 50) return Battery.P60
      if (percentage >= 40) return Battery.P50
      if (percentage >= 30) return Battery.P40
      if (percentage >= 20) return Battery.P30
      if (percentage >= 10) return Battery.P20

      return Battery.P10
    }


    Text {
        id: batteryIcon
        text: root.resolveBatteryState(UPower.displayDevice.state)
        // text: UPower.displayDevice.percentage
        font.pixelSize: 24
        font.family: "JetBrainsMono Nerd Font"
        color: mouseArea.containsMouse ? root.iconHoverColor : root.iconColor

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
      color: root.textBackground
      visible: root.showBatteryText
      radius: 4

      border.color: root.borderColor
      border.width: 2

      implicitWidth: batteryText.implicitWidth + 5
      implicitHeight: batteryText.implicitHeight + 3

      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter

      Text {
        id: batteryText
        text: UPower.displayDevice.percentage * 100 + "%"
        font.pixelSize: 12
        color: root.textColor

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
      }

    }

    property bool showBatteryText: false

    Timer {
      id: hoverTimer

      interval: 1000
      repeat: false

      onTriggered: root.showBatteryText = true
    }

    MouseArea {
      id: mouseArea
      anchors.fill: parent
      hoverEnabled: true

      onEntered: hoverTimer.start()
      onExited: {
        hoverTimer.stop()
        root.showBatteryText = false
      }
    }


}
