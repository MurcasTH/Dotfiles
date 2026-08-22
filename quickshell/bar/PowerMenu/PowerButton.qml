import Quickshell
import QtQuick

Rectangle {
    id: root
    required property PanelWindow bar

    // Button vars
    property color iconColor: "#f7768e"
    property color iconHoverColor: "#87768e"

    // PowerMenuCard vars
    property PowerCardStyle cardStyle: PowerCardStyle {}

    implicitWidth: bar.height
    implicitHeight: bar.height

    color: "Transparent"

    Text {
        anchors.centerIn: parent
        font.pixelSize: 24
        font.family: "JetBrainsMono Nerd Font"
        text: "⏻"

        color: mouseArea.containsMouse ? root.iconHoverColor : root.iconColor
    }

    anchors {
        right: parent.right
    }

    PowerMenuModel {
        id: powerMenuModule
        screen: root.bar.screen
    }

    PowerMenu {
        id: powerMenu
        bar: root.bar
        model: powerMenuModule

        cardStyle: root.cardStyle
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: powerMenuModule.toggle()
        hoverEnabled: true
    }
}
