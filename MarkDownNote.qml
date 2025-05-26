import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebEngine

import MarkDownNote 1.0
import "sidebar/sidebarToggle"

ApplicationWindow {
    id: mainWindow
    width: 800
    height: 600
    visible: true
    title: qsTr("Markdown Note")
    flags: Qt.Window | Qt.BypassWindowManagerHint

    header:NoteManager {
        id: note_manager
        Layout.fillWidth: true
        Layout.preferredHeight: 40
    }

    NoteContent {
        id: note_content
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
    SearchLocationList{
        id:searchLocationList
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

    Component.onCompleted: {
        MarkDownCtrl.expandCtrl.mainWindow = mainWindow
        MarkDownCtrl.menuCtrl.mainWindow = mainWindow
    }
}
