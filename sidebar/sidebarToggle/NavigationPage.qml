import QtQuick
import QtQuick.Controls

import "../../buttons"
import "../../dialogs"

Rectangle{
    id:navigationPage
    width: parent.width
    color:"transparent"

    Column{
        anchors.fill: parent
        Rectangle{
            id:bottonarea2
            width:parent.width
            height: 30
            color:"transparent"
            Row {
                width: parent.width
                spacing: 5
                Item {
                    id: textshow
                    width: parent.width*0.3
                    height: parent.height
                    Text{
                        text: "笔记本"
                        font.family: "Helvetica"
                        font.pointSize: 9
                        anchors.centerIn: textshow
                    }
                }
                ViewButton{}

                RecycleButton{}


                Button {
                    id:scan_import
                    onClicked: console.log("功能待实现")
                    icon.source: "qrc:/icons/scan_import.svg"
                    icon.width:15
                    background: Rectangle {
                        color: parent.hovered ? "#e0e0e0": "transparent"


                    }
                    ToolTip {
                            parent: scan_import
                            text: "扫描并导入"
                            font.pointSize: 8
                            y:22
                            visible: scan_import.hovered
                            delay: 300
                            padding: 4
                        }

                }

                ManageNotebookDialog {
                    id: notebookDialog
                }

                Manage_notebooksButton {
                    notebookDialog: notebookDialog
                }

                Button {
                    id:menu
                    onClicked: console.log("功能待实现")
                    icon.source: "qrc:/icons/menu.svg"
                    icon.width:15
                    background: Rectangle {
                        color: parent.hovered ?  "#e0e0e0": "transparent"

                    }
                    ToolTip {
                            parent: menu
                            text: "菜单"
                            font.pointSize: 8
                            y:22
                            visible: menu.hovered
                            delay: 300
                            padding: 4
                        }

                }

            }


        }

        ComboBox {
            id:noteComboBox
            anchors.margins: 5
            x:3
            width:parent.width-6
            height: 30
            model: ["自包含笔记本", "其他类型"]
        }


        Rectangle{
            id:notesshow
            width:parent.width
            height:parent.height-noteComboBox.height-bottonarea2.height
            color:"transparent"

            // 这里添加你的文件树视图内容
            ListView {
                id:listView
                anchors.fill: notesshow
                anchors.margins: 10
                model: ListModel {
                    ListElement { name: "笔记1.md"; checked: true  }
                    ListElement { name: "笔记2.md" ; checked: false }
                    ListElement { name: "笔记3.md" ; checked: false }
                }
                property int selectedIndex: 0

                delegate: ItemDelegate {
                    spacing: 5
                    width: notesshow.width-20
                    height: 25

                    Row {

                        anchors.centerIn: parent
                                Image {
                                    source: "qrc:/icons/file_node.svg"
                                    width: 15
                                    height: 15
                                    fillMode: Image.PreserveAspectFit
                                }
                                Text {
                                    id:textword
                                    font.pointSize: 9
                                    text: model.name
                                }
                            }

                    // 鼠标悬停时的背景色
                    background: Rectangle {
                        color: parent.hovered ? "#e0e0e0" : (index === listView.selectedIndex ?  "lightgray" : "transparent")


                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged: {
                            if(hovered) {
                                console.log(model.name + " hovered");
                            }
                        }
                        onClicked: {
                            // 更新选中索引
                            listView.selectedIndex = index;
                            // 更新模型中的checked状态
                            for (var i = 0; i < listView.model.count; ++i) {
                                listView.model.setProperty(i, "checked", i === index);
                            }
                            console.log(model.name + " selected");
                        }
                    }
                }
            }

         }

    }

}
