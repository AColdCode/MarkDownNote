import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebEngine

ApplicationWindow {
    width: 800
    height: 600
    visible: true
    title: "Markdown Note"

    ColumnLayout {
        anchors.fill: parent

        // 笔记管理
        NoteManager {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            TextArea {
                id: editor
                text: "# Hello Markdown\n\nThis is **bold** and *italic* text."
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: 18
            }

            PreviewPage {
                id: preview
                Layout.fillWidth: true
                Layout.fillHeight: true
                markdownText: editor.text
            }
        }
    }
}
