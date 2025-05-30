import QtQuick
import QtQuick.Controls

import "../../buttons"
import "../../dialogs"

import MarkDownNote 1.0

Rectangle{
    id:navigationPage
    width: parent.width
    color:"transparent"

    Column{
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
                onClicked:{
                    MarkDownCtrl.sidebarCtrl.showLabelChanged("Notebook")
                }
            }
        }

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
            id:notebookComboBox
            anchors.margins: 5
            x:3
            width:parent.width-6
            height: 30
            model: MarkDownCtrl.noteBookmodel
            textRole: "name"

            Connections {
                target: MarkDownCtrl.noteBookmodel
                function onCountChanged(newCount) {
                    notebookComboBox.currentIndex = newCount - 1
                }
            }

            onCurrentIndexChanged: {
                MarkDownCtrl.noteBookmodel.currentNotebook = MarkDownCtrl.noteBookmodel.getNotebookByIndex(currentIndex)
                note_listView.model = MarkDownCtrl.noteBookmodel.currentNotebook.notes
                MarkDownCtrl.noteBookCtrl.currentNotebookName = MarkDownCtrl.noteBookmodel.currentNotebook.name
            }
        }


        Rectangle{
            id:notesshow
            width:parent.width
            height:parent.height-notebookComboBox.height-bottonarea2.height-bottonarea1.height
            color:"transparent"

            // 这里添加你的文件树视图内容
            ListView {
                id:note_listView
                anchors.fill: notesshow
                anchors.margins: 10
                model: ListModel {
                    id: notemodel
                    ListElement { name: "笔记1.md" }
                    ListElement { name: "笔记2.md" }
                }

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

                    TapHandler {
                        onTapped: {
                            note_listView.currentIndex = index
                        }
                    }

                    // 鼠标悬停时的背景色
                    background: Rectangle {
                        color: parent.hovered ? "#e0e0e0" : (index === note_listView.currentIndex ?  "lightgray" : "transparent")
                    }
                }
            }
        }
    }

    Connections {
        target: MarkDownCtrl.noteBookmodel
        function onUpdateNoteModel() {
            note_listView.model = MarkDownCtrl.noteBookmodel.currentNotebook.notes
        }
    }
}
