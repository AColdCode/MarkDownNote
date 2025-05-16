import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
        width: 40
        height: parent.height
        color: "#354259"
        Column{
            anchors.fill: parent
            spacing: 1

            Button {
                id: notebookMenuButton
                Rectangle{
                    anchors.fill: parent
                    color: "#354259"
                }

                width: parent.width // 按钮宽度等于父级宽度
                icon.source: "qrc:/icons/notebook_menu.svg"
                icon.color: "#f6f3f3"
                icon.width: width * 0.6 // 图标宽度占按钮宽度的60%
                icon.height: icon.width // 保持图标宽高比一致
                onClicked: console.log("Notebook Menu")
            }


            Button {
                Rectangle{
                    anchors.fill: parent
                    color: "#354259"
                }
                width: parent.width
                icon.source: "qrc:/icons/tag_dock.svg"
                 icon.color:"#f6f3f3"
                icon.width: width * 0.6
                icon.height: icon.width
                onClicked: console.log("Tag Dock")
            }

            Button {
                Rectangle{
                    anchors.fill: parent
                    color: "#354259"
                }
                width: parent.width
                icon.source: "qrc:/icons/search_dock.svg"
                icon.color: "#f6f3f3"
                icon.width: width * 0.6
                icon.height: icon.width
                onClicked: console.log("Search Dock")
            }

            Button {
                Rectangle{
                    anchors.fill: parent
                    color: "#354259"
                }
                width: parent.width
                icon.source: "qrc:/icons/snippet_dock.svg"
                icon.color: "#f6f3f3"
                icon.width: width * 0.6
                icon.height: icon.width
                onClicked: console.log("Snippet Dock")

            }
        }



}
