import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io

FloatingWindow {
    id: launcherWindow

    // Hyprland can match this title for window rules.
    title: "qs-launcher"
    color: "transparent"
    surfaceFormat.opaque: false

    implicitWidth: theme.windowWidth
    implicitHeight: theme.windowHeight
    visible: false

    IpcHandler {
        target: "launcher"

        function toggle(): string {
            launcherWindow.visible = !launcherWindow.visible;

            if (launcherWindow.visible)
                launcherWindow.prepareForOpening();

            return "launcher visible = " + launcherWindow.visible;
        }

        function show(): string {
            launcherWindow.visible = true;
            launcherWindow.prepareForOpening();

            return "launcher visible = " + launcherWindow.visible;
        }

        function hide(): string {
            launcherWindow.visible = false;
            return "launcher visible = " + launcherWindow.visible;
        }
    }

    // =========================
    // EDIT THE LOOK HERE
    // =========================
    QtObject {
        id: theme

        property int windowWidth: 720
        property int windowHeight: 520

        property int outerMargin: 16
        property int windowRadius: 22
        property int rowHeight: 54
        property int rowRadius: 14
        property int iconSize: 30

        property color background: "#11111b"
        property color foreground: "#cdd6f4"
        property color mutedForeground: "#7f849c"
        property color searchBackground: "#181825"
        property color selectedBackground: "#313244"
        property color borderColor: "#45475a"
        property color accent: "#89b4fa"

        property string fontFamily: "Inter"
        property int appNameSize: 13
        property int commentSize: 10
        property int searchSize: 15

        property string terminal: "foot"
    }

    property string query: ""

    FileView {
        id: usageFile
        path: Quickshell.statePath("launcher-usage.json")
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: usageData
            property var launchCounts: ({})
        }
    }

    function prepareForOpening() {
        query = "";
        searchField.text = "";
        appList.currentIndex = filteredApps.values.length > 0 ? 0 : -1;
        searchField.forceActiveFocus();
    }

    function appKey(entry) {
        return entry.id || entry.execString || entry.name;
    }

    function launchCount(entry) {
        return usageData.launchCounts[appKey(entry)] || 0;
    }

    function recordLaunch(entry) {
        const counts = Object.assign({}, usageData.launchCounts);
        const key = appKey(entry);
        counts[key] = (counts[key] || 0) + 1;
        usageData.launchCounts = counts;
    }

    function searchScore(entry, searchText) {
        const queryText = searchText.toLowerCase();
        const appName = (entry.name || "").toLowerCase();
        const genericName = (entry.genericName || "").toLowerCase();
        const comment = (entry.comment || "").toLowerCase();
        const keywords = (entry.keywords || []).join(" ").toLowerCase();
        const categories = (entry.categories || []).join(" ").toLowerCase();

        // Lower scores sort first. Title matches always beat metadata matches.
        if (appName === queryText)
            return 0;
        if (appName.startsWith(queryText))
            return 10;
        if (appName.includes(queryText))
            return 20;
        if (genericName.startsWith(queryText))
            return 30;
        if (genericName.includes(queryText))
            return 40;
        if (keywords.includes(queryText))
            return 50;
        if (comment.includes(queryText))
            return 60;
        if (categories.includes(queryText))
            return 70;

        return -1;
    }

    function launch(entry) {
        if (entry === null || entry === undefined)
            return;

        recordLaunch(entry);

        // Quickshell's DesktopEntry.execute() ignores runInTerminal.
        // This makes terminal apps open in Foot instead.
        if (entry.runInTerminal) {
            Quickshell.execDetached({
                command: [theme.terminal, "-e"].concat(entry.command),
                workingDirectory: entry.workingDirectory
            });
        } else {
            entry.execute();
        }

        launcherWindow.visible = false;
    }

    ScriptModel {
        id: filteredApps

        values: {
            const allEntries = [...DesktopEntries.applications.values].filter(entry => entry.name);
            const trimmedQuery = launcherWindow.query.trim();

            return allEntries
                .map(entry => ({
                    entry: entry,
                    score: trimmedQuery === "" ? 0 : launcherWindow.searchScore(entry, trimmedQuery),
                    launches: launcherWindow.launchCount(entry)
                }))
                .filter(result => trimmedQuery === "" || result.score >= 0)
                .sort((leftResult, rightResult) => {
                    if (leftResult.score !== rightResult.score)
                        return leftResult.score - rightResult.score;

                    if (leftResult.launches !== rightResult.launches)
                        return rightResult.launches - leftResult.launches;

                    return leftResult.entry.name.localeCompare(rightResult.entry.name);
                })
                .map(result => result.entry);
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: theme.windowRadius
        color: theme.background
        border.color: theme.borderColor
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: theme.outerMargin
            spacing: 14

            TextField {
                id: searchField

                Layout.fillWidth: true
                Layout.preferredHeight: 52

                text: launcherWindow.query
                placeholderText: "Search apps..."
                color: theme.foreground
                placeholderTextColor: theme.mutedForeground
                font.family: theme.fontFamily
                font.pixelSize: theme.searchSize
                selectByMouse: true

                background: Rectangle {
                    radius: 16
                    color: theme.searchBackground
                    border.color: searchField.activeFocus ? theme.accent : theme.borderColor
                    border.width: 1
                }

                leftPadding: 18
                rightPadding: 18

                onTextChanged: {
                    launcherWindow.query = text;
                    appList.currentIndex = filteredApps.values.length > 0 ? 0 : -1;
                }

                Keys.onPressed: function (event) {
                    if (event.key === Qt.Key_Escape) {
                        event.accepted = true;
                        launcherWindow.visible = false;
                    }

                    if (event.key === Qt.Key_Down) {
                        event.accepted = true;
                        if (appList.currentIndex < appList.count - 1)
                            appList.currentIndex++;
                    }

                    if (event.key === Qt.Key_Up) {
                        event.accepted = true;
                        if (appList.currentIndex > 0)
                            appList.currentIndex--;
                    }

                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        event.accepted = true;
                        launcherWindow.launch(filteredApps.values[appList.currentIndex]);
                    }
                }

                Component.onCompleted: forceActiveFocus()
            }

            ListView {
                id: appList

                Layout.fillWidth: true
                Layout.fillHeight: true

                clip: true
                spacing: 6

                model: filteredApps.values
                currentIndex: filteredApps.values.length > 0 ? 0 : -1

                delegate: Rectangle {
                    id: appRow

                    required property var modelData
                    required property int index

                    width: appList.width
                    height: theme.rowHeight
                    radius: theme.rowRadius

                    color: ListView.isCurrentItem ? theme.selectedBackground : "transparent"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: appList.currentIndex = appRow.index
                        onClicked: launcherWindow.launch(appRow.modelData)
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 14
                        anchors.rightMargin: 14
                        spacing: 14

                        IconImage {
                            Layout.preferredWidth: theme.iconSize
                            Layout.preferredHeight: theme.iconSize

                            source: Quickshell.iconPath(appRow.modelData.icon, true)
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                Layout.fillWidth: true

                                text: appRow.modelData.name
                                color: theme.foreground
                                font.family: theme.fontFamily
                                font.pixelSize: theme.appNameSize
                                elide: Text.ElideRight
                            }

                            Text {
                                Layout.fillWidth: true

                                text: appRow.modelData.comment || appRow.modelData.genericName || appRow.modelData.execString || ""
                                color: theme.mutedForeground
                                font.family: theme.fontFamily
                                font.pixelSize: theme.commentSize
                                elide: Text.ElideRight
                                visible: text.length > 0
                            }
                        }
                    }
                }

                ScrollBar.vertical: ScrollBar {}
            }
        }
    }
}
