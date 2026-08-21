pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

Item {
    id: root

    required property ShellScreen screen
    property bool currentMonitorOnly: true

    property int buttonSize: 28
    property int spacing: 6
    property int buttonPadding: 3
    property int radius: 7
    property int iconSpacing: 3
    property int appIconSize: 18

    function appIdentifier(toplevel) {
        if (toplevel === null || toplevel === undefined) {
            return "";
        }

        // Preferred source for native Wayland applications.
        if (toplevel.wayland !== null && toplevel.wayland !== undefined) {
            const appId = toplevel.wayland.appId;

            if (typeof appId === "string" && appId.length > 0) {
                return appId;
            }
        }

        // Fallback to Hyprland's IPC information.
        const ipc = toplevel.lastIpcObject;

        if (ipc !== null && ipc !== undefined) {
            if (typeof ipc.class === "string" && ipc.class.length > 0) {
                return ipc.class;
            }

            if (typeof ipc.initialClass === "string" && ipc.initialClass.length > 0) {
                return ipc.initialClass;
            }
        }

        return "";
    }

    function iconForToplevel(toplevel) {
        const identifier = root.appIdentifier(toplevel);

        if (identifier === "") {
            return Quickshell.iconPath("application-x-executable");
        }
        // Keep unidentified windows rather than discarding them.
        const desktopEntry = DesktopEntries.heuristicLookup(identifier);

        if (desktopEntry !== null && desktopEntry.icon !== "") {
            return Quickshell.iconPath(desktopEntry.icon, "application-x-executable");
        }

        return Quickshell.iconPath(identifier, "application-x-executable");
    }

    function uniqueToplevels(workspace) {
        const seen = {};

        return [...workspace.toplevels.values].filter(toplevel => {
            const identifier = root.appIdentifier(toplevel).toLowerCase();
            const key = identifier !== "" ? identifier : toplevel.address;

            if (seen[key]) {
                return false;
            }
            seen[key] = true;
            return true;
        });
    }

    // Default Colors
    property color activeColor: "#89b4fa"
    property color inactiveColor: "#181825"
    property color hoverColor: "#313244"
    property color textColor: "#cdd6f4"
    property color activeTextColor: "#11111b"
    property color urgentColor: "#f38ba8"

    implicitWidth: workspaceRow.implicitWidth
    implicitHeight: workspaceRow.implicitHeight

    WorkspaceModel {
        id: workspaceModel

        screen: root.screen
        currentMonitorOnly: root.currentMonitorOnly
    }

    Row {
        id: workspaceRow

        spacing: root.spacing

        Repeater {
            model: workspaceModel

            delegate: Rectangle {
                id: workspaceButton

                required property HyprlandWorkspace modelData
                readonly property HyprlandWorkspace workspace: workspaceButton.modelData

                width: Math.max(root.buttonSize, applicationIcons.implicitWidth + root.buttonPadding * 2)
                height: root.buttonSize
                radius: root.radius

                color: {
                    if (workspace.active) {
                        return root.activeColor;
                    }
                    if (mouseArea.containsMouse) {
                        return root.hoverColor;
                    }
                    return root.inactiveColor;
                }

                border.width: workspace.urgent ? 2 : 0
                border.color: root.urgentColor

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                ScriptModel {
                    id: applicationModel

                    values: root.uniqueToplevels(workspaceButton.workspace)
                }

                Row {
                    id: applicationIcons

                    anchors.centerIn: parent
                    spacing: root.iconSpacing

                    Repeater {
                        id: applicationRepeater

                        model: applicationModel

                        delegate: IconImage {
                            required property HyprlandToplevel modelData

                            implicitSize: root.appIconSize
                            source: root.iconForToplevel(modelData)

                            mipmap: true
                        }
                    }
                }

                // Show the workspace number when it contains no applications.
                Text {
                    anchors.centerIn: parent

                    visible: applicationRepeater.count === 0
                    text: workspaceButton.workspace.name

                    color: workspaceButton.workspace.active ? root.activeTextColor : root.textColor

                    font.bold: workspaceButton.workspace.active
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: workspaceButton.workspace.activate()
                }
            }
        }
    }
}
