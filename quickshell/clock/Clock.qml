import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: overlay
            required property ShellScreen modelData
            property real aspectRatio: screen.width / screen.height
            screen: modelData

            implicitWidth: modelData.width
            implicitHeight: modelData.height

            color: "transparent"
            focusable: false

            WlrLayershell.layer: WlrLayer.Bottom

            mask: Region {}

            SystemClock {
                id: clock
                precision: SystemClock.Minutes
            }

            Loader {
                id: walColors
                source: "file://" + Quickshell.env("HOME") + "/.cache/wal/colors.qml"
            }

            Text {
                x: overlay.screen.width * 0.1
                y: overlay.screen.height * 0.1

                text: Qt.formatDateTime(clock.date, "hh:mm")

                renderType: Text.NativeRendering
                font.pixelSize: Math.round(65 * overlay.aspectRatio)
                font.family: "M PLUS Rounded 1c"
                font.weight: Font.Black
                color: walColors.item?.color3
            }
        }
    }
}
