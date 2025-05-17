import QtQuick
import QtQuick.Layouts

RowLayout {
    anchors.fill: parent

    Sidebar {
        id:sidebar
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.horizontalStretchFactor: 0
    }

    EditorPage {
        id: editor
        Layout.fillWidth: true
        Layout.fillHeight: true
        font.pixelSize: 18
        Layout.horizontalStretchFactor: 1
    }

    PreviewPage {
        id: preview
        Layout.fillWidth: true
        Layout.fillHeight: true
        markdownText: editor.text
        Layout.horizontalStretchFactor: 1
    }
}
