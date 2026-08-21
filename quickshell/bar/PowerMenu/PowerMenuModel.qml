import Quickshell
import QtQuick

QtObject {
    id: root

    required property ShellScreen screen
    property bool open: false

    function toggle() {
        root.open = !root.open;
    }

    function close() {
        root.open = false;
    }

    function show() {
        root.open = true;
    }
}
