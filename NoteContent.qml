import QtQuick
import QtQuick.Layouts

import MarkDownNote 1.0

RowLayout {

    spacing: 0

    anchors.fill: parent


    Sidebar {
        id:sidebar
        Layout.fillWidth: true
        Layout.fillHeight: true

        Layout.horizontalStretchFactor: 0

    }
    SidebarResponsiveArea{
        Layout.fillWidth: true
        Layout.fillHeight: true
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

    Component.onCompleted: {
        MarkDownCtrl.expandCtrl.sidebar = sidebar
    }
}
