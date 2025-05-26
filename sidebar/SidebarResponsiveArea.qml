import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MarkDownNote
import "sidebarToggle"

Rectangle {
    id: fileTreeView
    width: 200
    height: parent.height
    color: "#efeded"
    property int  currentIndex: 0

    ColumnLayout {
        anchors.fill: parent

        Rectangle{
            id:bottonarea1
            width: parent.width
            height: 20
            color: "#e0e0e0"
            Button {
                id:button
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "qrc:/icons/close.svg"
                icon.width:12
                icon.height:12
                icon.color:"black"
                background: Rectangle {
                    color: button.hovered ? "lightgray" : "transparent"
                }
                onClicked:fileTreeView.visible=false
            }
        }

        SearchPage{
            id:searchPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: currentIndex===2
        }

        HistoryPage{
            id:historyPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: currentIndex===1
        }

        NavigationPage{
            id:navigationPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: currentIndex===0
        }
    }
    Component.onCompleted: {
        MarkDownCtrl.sidebarCtrl.fileTreeView=fileTreeView;
    }
}

