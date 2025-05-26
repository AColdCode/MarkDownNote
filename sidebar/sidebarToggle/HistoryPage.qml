import QtQuick
import QtQuick.Controls

Rectangle{
    id:historyPage
    width: parent.width
    color:"transparent"

    Column{
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5
        Rectangle{
            id:bottonarea
            width:parent.width
            height: 20
            color:"transparent"
            Button{
                id:clearbutton
                onClicked: console.log("功能待实现")
                icon.source: "qrc:/icons/clear.svg"
                icon.width:15
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                background: Rectangle {
                    color: parent.hovered ? "#e0e0e0": "transparent"


                }
                ToolTip {
                        parent: clearbutton
                        text: "清空"
                        font.pointSize: 8
                        y:22
                        visible: clearbutton.hovered
                        delay: 300
                        padding: 4
                    }
            }
        }
        Rectangle{
            id:texttitle1
            width:parent.width
            height: 20
            color:"lightgray"

            Text{
                text: "今天"
                font.family: "Helvetica"
                // font.pointSize: 9
                anchors.left: texttitle1.left
                anchors.margins: 5
            }

        }
        Rectangle{
            id:notesshow
            width:parent.width
            height: 100
            // height:parent.height-noteComboBox.height-bottonarea2.height
            color:"transparent"

            // 这里添加你的文件树视图内容
            ListView {
                id:listView
                anchors.fill: notesshow
                // anchors.margins: 10
                model: ListModel {
                    ListElement { name: "笔记1.md"; checked: true  }
                    ListElement { name: "笔记2.md" ; checked: false }
                    ListElement { name: "笔记3.md" ; checked: false }
                }
                property int selectedIndex: -1

                delegate: ItemDelegate {
                    spacing: 5
                    width: notesshow.width
                    height: 25

                    Row {

                        anchors.fill:parent
                                Image {
                                    source: "qrc:/icons/file_node.svg"
                                    width: 15
                                    height: 15
                                    fillMode: Image.PreserveAspectFit
                                }
                                Text {
                                    id:textword
                                    font.pointSize: 10
                                    text: model.name
                                }
                            }

                    // 鼠标悬停时的背景色
                    background: Rectangle {
                        color: parent.hovered ? "#e0e0e0" : (index === listView.selectedIndex ?  "#e0e0e0" : "transparent")


                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            // 更新选中索引
                            listView.selectedIndex = index;
                            // 更新模型中的checked状态
                            for (var i = 0; i < listView.model.count; ++i) {
                                listView.model.setProperty(i, "checked", i === index);
                            }

                        }
                    }
                }
            }

         }
    }
}
