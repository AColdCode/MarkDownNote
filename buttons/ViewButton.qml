import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: viewbutton
    onClicked: viewmenu.popup()
    icon.source: "qrc:/icons/view.svg"
    icon.width: 15
    icon.color: "black"
    background: Rectangle {
        color: parent.hovered ? "#e0e0e0" : "transparent"
    }

    ToolTip {
        parent: viewbutton
        text: "查看方式"
        font.pointSize: 8
        y: 22
        visible: viewbutton.hovered
        delay: 300
        padding: 4
    }

    Menu {
        id: viewmenu
        y: viewbutton.height // 将菜单定位在按钮下方

        Menu {
            id: subMenuNotebook
            title: "笔记本"

            height: notebooklistView.contentHeight // 设置Popup的高度等于ListView的内容高度
            ListView {
                id: notebooklistView
                width: parent.width
                height: contentHeight // 动态调整高度以适应内容
                model: ListModel {
                       ListElement { name: "按配置查看"; checked: true}
                       ListElement { name: "按名字查看"; checked: false }
                       ListElement { name: "按名字倒序查看"; checked: false }
                       ListElement { name: "按创建时间查看"; checked: false}
                       ListElement { name: "按创建时间倒序查看"; checked: false}


                   }

                property int selectedIndex: 0 // 默认选中的索引

                delegate: ItemDelegate {
                    width: parent.width
                    height: 30

                    Row {
                        spacing: 10
                        Rectangle {
                            y:10
                            width: 8
                            height: 8
                            radius: 5
                            color: model.checked ? "black" : "transparent" // 根据选中状态改变颜色
                            Layout.alignment: Qt.AlignVCenter // 垂直居中对齐
                        }
                        Text {
                            y:6
                            text: model.name
                            color: "black"
                            Layout.alignment: Qt.AlignVCenter // 垂直居中对齐
                        }
                    }

                    // 鼠标悬停时的背景色
                    background: Rectangle {
                        color: hovered ? "#35bfa4" : "transparent" // 当鼠标悬停时变为灰色
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true // 启用悬停检测
                        onHoveredChanged: {
                            if(hovered) {
                                console.log(model.name + " hovered");
                            }
                        }
                        onClicked: {
                            // 更新选中索引
                            notebooklistView.selectedIndex = index;
                            // 更新模型中的checked状态
                            for (var i = 0; i < notebooklistView.model.count; ++i) {
                                notebooklistView.model.setProperty(i, "checked", i === index);
                            }
                            console.log(model.name + " selected");
                        }
                    }
                }
            }
        }

        Menu {
            id: subMenuNotes
            title: "笔记"

            height: notelistView.contentHeight // 设置Popup的高度等于ListView的内容高度
            ListView {
                id: notelistView
                width: parent.width
                height: contentHeight // 动态调整高度以适应内容
                model: ListModel {
                       ListElement { name: "按配置查看"; checked: true}
                       ListElement { name: "按名字查看"; checked: false }
                       ListElement { name: "按名字倒序查看"; checked: false }
                       ListElement { name: "按创建时间查看"; checked: false}
                       ListElement { name: "按创建时间倒序查看"; checked: false}
                       ListElement { name: "按修改时间查看"; checked: false}
                       ListElement { name: "按修改时间倒序查看"; checked: false }

                   }

                property int selectedIndex: 0 // 默认选中的索引

                delegate: ItemDelegate {
                    width: parent.width
                    height: 30

                    Row {
                        spacing: 10
                        Rectangle {
                            y:10
                            width: 8
                            height: 8
                            radius: 5
                            color: model.checked ? "black" : "transparent" // 根据选中状态改变颜色
                            Layout.alignment: Qt.AlignVCenter // 垂直居中对齐
                        }
                        Text {
                            y:6
                            text: model.name
                            color: "black"
                            Layout.alignment: Qt.AlignVCenter // 垂直居中对齐
                        }
                    }

                    // 鼠标悬停时的背景色
                    background: Rectangle {
                        color: hovered ? "#35bfa4" : "transparent" // 当鼠标悬停时变为灰色
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true // 启用悬停检测
                        onHoveredChanged: {
                            if(hovered) {
                                console.log(model.name + " hovered");
                            }
                        }
                        onClicked: {
                            // 更新选中索引
                            notelistView.selectedIndex = index;
                            // 更新模型中的checked状态
                            for (var i = 0; i < notelistView.model.count; ++i) {
                                notelistView.model.setProperty(i, "checked", i === index);
                            }
                            console.log(model.name + " selected");
                        }
                    }
                }
            }
        }
    }
}
