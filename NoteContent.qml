import QtQuick
import QtQuick.Layouts

import MarkDownNote 1.0

RowLayout {
    spacing: 0
    anchors.fill: parent

    RightContent {
        id: rightContent
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.horizontalStretchFactor: 0
    }

    LeftContent {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.horizontalStretchFactor: 1
    }

    Component.onCompleted: {
        MarkDownCtrl.expandCtrl.rightContent = rightContent
    }
}
