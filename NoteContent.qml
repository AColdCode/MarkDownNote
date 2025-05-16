import QtQuick
import QtQuick.Layouts

RowLayout {

    EditorPage {
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
