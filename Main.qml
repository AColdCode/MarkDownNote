import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebEngine

ApplicationWindow {
    width: 800
    height: 600
    visible: true
    title: "Markdown Note"

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
}
