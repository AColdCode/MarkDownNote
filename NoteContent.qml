import QtQuick
import QtQuick.Layouts

import "sidebar/sidebarToggle"
import MarkDownNote 1.0

ColumnLayout{
    spacing: 0
    anchors.fill: parent

    RowLayout {
        spacing: 0
        Layout.fillWidth: true
        height: parent.height-searchLocationList.height
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
    SearchLocationList{
        id:searchLocationList
        visible: false
        Layout.fillWidth: true
    }

}


