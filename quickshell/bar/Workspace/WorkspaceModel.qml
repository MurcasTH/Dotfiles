import Quickshell
import Quickshell.Hyprland

ScriptModel {
    id: root

    // The screen belonging to the bar
    required property var screen

    // Set to false to show workspaces from every monitor
    property bool currentMonitorOnly: true

    readonly property var hyprlandMonitor: Hyprland.monitorFor(root.screen)

    values: {
        const monitor = root.hyprlandMonitor;

        return [...Hyprland.workspaces.values].filter(workspace => workspace.id > 0).filter(workspace => {
            if (!root.currentMonitorOnly) {
                return true;
            }
            if (monitor === null || workspace.monitor === null) {
                return false;
            }
            return workspace.monitor.name === monitor.name;
        }).sort((left, right) => left.id - right.id);
    }
}
