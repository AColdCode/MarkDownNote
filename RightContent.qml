import QtQuick
import QtQuick.Layouts

import MarkDownNote 1.0

import "sidebar"

RowLayout {
    spacing: 0

    Sidebar {
        id:sidebar
        width: 40
        Layout.fillHeight: true
    }

    SidebarResponsiveArea {
        id: sidebarResponsiveArea
        width: 200
        Layout.fillHeight: true
    }
}

