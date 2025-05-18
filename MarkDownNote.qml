import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebEngine

import MarkDownNote 1.0

ApplicationWindow {
    id: mainWindow
    width: 800
    height: 600
    visible: true
    title: "Markdown Note"
    flags: Qt.Window | Qt.BypassWindowManagerHint

    header:NoteManager {
        id: note_manager
        Layout.fillWidth: true
        Layout.preferredHeight: 40
    }

    NoteContent{
        id: note_content
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

    Component.onCompleted: {
        MarkDownCtrl.mainWindow = mainWindow
    }
}
