import Quickshell
import QtQuick

import qs.bar.Workspace as WorkspaceModule
import qs.themes as Themes
import qs.bar.PowerMenu as PowerMenuModule

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property ShellScreen modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 40

            color: Themes.TokyoNight.background

            WorkspaceModule.Workspaces {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 10
                }

                currentMonitorOnly: true

                screen: bar.screen

                activeColor: Themes.TokyoNight.accent
                inactiveColor: Themes.TokyoNight.searchBackground
                hoverColor: Themes.TokyoNight.selectedBackground
                textColor: Themes.TokyoNight.foreground
                activeTextColor: Themes.TokyoNight.background
            }

            PowerMenuModule.PowerButton {
                bar: bar
                iconColor: Themes.TokyoNight.accent

                cardStyle: PowerMenuModule.PowerCardStyle {
                    backgroundColor: Themes.TokyoNight.searchBackground
                    borderColor: Themes.TokyoNight.selectedBackground
                    iconColor: Themes.TokyoNight.accent
                }
            }
        }
    }
}
