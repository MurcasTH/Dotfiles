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

    color: cardStyle.backgroundColor

    border.width: cardStyle.borderWidth
    border.color: cardStyle.borderColor

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }

    Text {
        id: icon

        anchors.centerIn: parent
        text: root.icon
        font.pixelSize: root.cardStyle.pixelSize
        font.family: "JetBrainsMono Nerd"
        color: root.cardStyle.iconColor
    }
}
