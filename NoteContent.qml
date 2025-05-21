import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 0

    Sidebar {
        id:sidebar
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
    SidebarResponsiveArea{
        Layout.fillWidth: true
        Layout.fillHeight: true
    }



    EditorPage {
        id: editor
        // text: "# Hello Markdown\n\nThis is **bold** and *italic* text."
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
