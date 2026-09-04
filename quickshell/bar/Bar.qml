import Quickshell
import QtQuick

import qs.bar.Workspace as WorkspaceModule
import qs.themes as Themes
import qs.bar.PowerMenu as PowerMenuModule
import qs.bar.Battery as BatteryModule

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

                activeColor: Themes.TokyoNight.iconActiveColor
                inactiveColor: Themes.TokyoNight.searchBackground
                hoverColor: Themes.TokyoNight.iconHoverColor
                textColor: Themes.TokyoNight.foreground
                activeTextColor: Themes.TokyoNight.background
            }
            Row {
                id: rightModules

                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }

                BatteryModule.Battery {
                    anchors.verticalCenter: parent.verticalCenter

                    iconColor: Themes.TokyoNight.iconColor
                    iconHoverColor: Themes.TokyoNight.iconHoverColor
                    textColor: Themes.TokyoNight.primaryForeground
                    textBackground: Themes.TokyoNight.elevatedBackground
                    borderColor: Themes.TokyoNight.subtleBorderColor
                }

                PowerMenuModule.PowerButton {
                    bar: bar
                    iconColor: Themes.TokyoNight.iconColor
                    iconHoverColor: Themes.TokyoNight.iconHoverColor

                    cardStyle: PowerMenuModule.PowerCardStyle {
                        backgroundColor: Themes.TokyoNight.buttonBackground
                        backgroundHoverColor: Themes.TokyoNight.buttonHoverBackground

                        iconColor: Themes.TokyoNight.iconColor
                        iconHoverColor: Themes.TokyoNight.iconHoverColor

                        borderColor: Themes.TokyoNight.buttonBorderColor
                        borderWidth: 2
                    }
                }
            }
        }
    }
}
