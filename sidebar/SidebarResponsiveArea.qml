import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "sidebarToggle"

Rectangle {
    id: fileTreeView
    width: 200
    height: parent.height
    color: "#efeded"

    ColumnLayout {
        anchors.fill: parent


        Rectangle{
                id:bottonarea1
            width: parent.width
            height: 20
            color: "#e0e0e0"
            Row {
                width: parent.width
                spacing: 0
                Rectangle{
                    width: parent.width* 0.78
                    height: 20
                    color: "transparent"
                }
                Button {
                    onClicked: console.log("功能待实现")
                    icon.source: "qrc:/icons/float.svg"
                    icon.width:13
                    icon.color:"black"

                    background: Rectangle {
                        color: "transparent"
                    }
                }
                Button {
                    onClicked: console.log("功能待实现")
                    icon.source: "qrc:/icons/close.svg"
                    icon.width:13
                    background: Rectangle {
                        color: "transparent"

                    }

                }
            }
        }
        NavigationPage{
            Layout.fillWidth: true
            Layout.fillHeight: true
        }


    }
}
