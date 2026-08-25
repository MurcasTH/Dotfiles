import QtQuick

Rectangle {
    id: root
    property string label: ""
    property string icon: ""

    // Style
    property PowerCardStyle cardStyle: PowerCardStyle {}

    signal clicked

    implicitWidth: cardStyle.width
    implicitHeight: cardStyle.height
    radius: cardStyle.radius

    color: mouseArea.containsMouse ? cardStyle.backgroundHoverColor : cardStyle.backgroundColor
    opacity: 0.8

    border.width: cardStyle.borderWidth
    border.color: cardStyle.borderColor

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()

        hoverEnabled: true
    }

    Text {
        id: icon

        anchors.centerIn: parent
        text: root.icon
        font.pixelSize: root.cardStyle.pixelSize
        font.family: "JetBrainsMono Nerd"
        color: mouseArea.containsMouse ? root.cardStyle.iconHoverColor : root.cardStyle.iconColor
    }
}
