pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Item {
    id: root

    required property PanelWindow bar
    required property PowerMenuModel model

    required property PowerCardStyle cardStyle

    function runAction(action) {
        switch (action) {
        case "shutdown":
            Quickshell.execDetached(["systemctl", "poweroff"]);
            break;
        case "sleep":
            Quickshell.execDetached(["systemctl", "suspend"]);
            break;
        case "logout":
            Quickshell.execDetached(["hyprctl", "dispatch", "hl.dsp.exit()"]);
            break;
        case "restart":
            Quickshell.execDetached(["systemctl", "reboot"]);
            break;
        }
    }

    PanelWindow {
        screen: root.model.screen
        visible: root.model.open

        // Makes my shortcut funciton
        focusable: true

        anchors {
            top: true
            left: true
            bottom: true
            right: true
        }

        // Makes it so PowerMenu doesn't reserver screenspace for itself
        exclusionMode: ExclusionMode.Ignore

        color: "#80000000"

        MouseArea {
            anchors.fill: parent
            onClicked: root.model.close()
        }

        Shortcut {
            sequence: "Escape"
            onActivated: root.model.close()
        }

        Row {
            anchors.centerIn: parent
            spacing: 100

            Repeater {
                model: [
                    {
                        name: "Shutdown",
                        icon: "",
                        action: "shutdown"
                    },
                    {
                        name: "Sleep",
                        icon: "",
                        action: "sleep"
                    },
                    {
                        name: "Logout",
                        icon: "󰍃",
                        action: "logout"
                    },
                    {
                        name: "Restart",
                        icon: "",
                        action: "restart"
                    }
                ]

                delegate: PowerCard {
                    required property var modelData
                    label: modelData.name
                    icon: modelData.icon

                    cardStyle: root.cardStyle

                    onClicked: {
                        root.runAction(modelData.action);
                        root.model.close();
                    }
                }
            }
        }
    }
}
