import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MarkDownNote

Rectangle{
    id:historyPage
    width: parent.width
    height:parent.height
    color:"transparent"

    ColumnLayout{
        anchors.fill: parent
        spacing: 0
        Rectangle{
            id:bottonarea1
            Layout.fillWidth: true
            Layout.preferredHeight: 20
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
                    MarkDownCtrl.sidebarCtrl.showLabelChanged("History")
                }
            }
        }

        Rectangle{
            id:bottonarea2
            Layout.fillWidth: true
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
            Layout.fillWidth: true
            height: 20
            Layout.margins: 5
            color:"lightgray"

            Text{
                text: "今天"
                font.family: "Helvetica"
                // font.pointSize: 9
                anchors.left: texttitle1.left
                anchors.margins: 5
            }

        }
        ScrollView {
            id: mainScrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 5
            clip: true  // 重要：确保内容不会溢出

            // 内容区域
            Rectangle {
                id: notesshow
                width: mainScrollView.availableWidth  // 使用可用宽度
                height: Math.max(implicitHeight, mainScrollView.availableHeight)  // 动态高度
                color:"transparent"

                // 文件树视图
                ListView {
                    id: listView
                    anchors.fill: parent
                    boundsBehavior: Flickable.StopAtBounds  // 边界行为控制
                    model: ListModel {
                        ListElement { name: "笔记1.md"; checked: true }
                        ListElement { name: "笔记2.md"; checked: false }
                        ListElement { name: "笔记2.md" ; checked: false }
                        ListElement { name: "笔记3.md" ; checked: false }
                        // ... 其他列表项 ...
                    }
                    property int selectedIndex: -1

                    // 滚动条设置
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AsNeeded  // 按需显示
                        width: 10  // 滚动条宽度
                    }

                    // 代理项
                    delegate: ItemDelegate {
                        width: listView.width
                        height: 25

                        // 内容布局
                        Row {
                            anchors.fill: parent
                            spacing: 5

                            Image {
                                source: "qrc:/icons/file_node.svg"
                                width: 15
                                height: 15
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                text: model.name
                                font.pointSize: 10
                            }
                        }

                        // 背景效果
                        background: Rectangle {
                            color: {
                                if (index === listView.selectedIndex) return "#e0e0e0";
                                return hovered ? "#f0f0f0" : "transparent";
                            }
                        }

                        // 鼠标交互
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                listView.selectedIndex = index;
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
}
