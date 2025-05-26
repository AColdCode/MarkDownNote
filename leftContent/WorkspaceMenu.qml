// WorkspaceMenu.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Button {
    id:button
    background: Rectangle {
        color: parent.hovered ? "#e0e0e0": "transparent"//最新更改
    }
    icon.source: "qrc:/icons/menu.svg"
    onClicked:menu.open()

    Menu {
        id: menu
        y: button.height + button.y
        width: 230

        height: listView.contentHeight // 设置Popup的高度等于ListView的内容高度
        ListView {
            id: listView
            width: parent.width
            height: contentHeight // 动态调整高度以适应内容
            model: ListModel {
                   ListElement { name: "工作空间1"; checked: true; shortcut: "" }
                   ListElement { name: "工作空间2"; checked: false; shortcut: "" }
                   ListElement { name: "新建工作空间"; checked: false; shortcut: "" }
                   ListElement { name: "移除工作空间"; checked: false; shortcut: "" }
                   ListElement { name: "竖直拆分                "; checked: false; shortcut: "Ctrl+G, \\" }
                   ListElement { name: "水平拆分                "; checked: false; shortcut: "Ctrl+G, -" }
                   ListElement { name: "最大化拆分             "; checked: false; shortcut: "Ctrl+G, Shift+\\" }
                   ListElement { name: "平均分配拆分          "; checked: false; shortcut: "Ctrl+G, =" }
                   ListElement { name: "移除拆分"; checked: false; shortcut: "" }
                   ListElement { name: "移除拆分和工作空间"; checked: false; shortcut: "Ctrl+G, R" }
               }

            property int selectedIndex: 0 // 默认选中的索引

            delegate: ItemDelegate {
                width: parent.width
                height: 30

                RowLayout {
                    spacing: 10
                    Rectangle {
                        Layout.leftMargin: 5
                        y:10
                        width: 6
                        height: 6
                        radius: 5
                        color: model.checked ? "black" : "transparent" // 根据选中状态改变颜色
                        Layout.alignment: Qt.AlignVCenter // 垂直居中对齐
                    }
                    Text {
                        y:6
                        text: model.name
                        font.pixelSize: 12
                        color: "black"
                        Layout.alignment: Qt.AlignVCenter // 垂直居中对齐
                    }
                    Text {
                            y:6
                            text: model.shortcut
                            font.pixelSize: 10
                            color: "black"
                            visible: model.shortcut !== ""
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        }
                }
                // 分割线
                Rectangle {
                    color: "lightgray" // 设置分割线的颜色
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom // 锚定到底部
                    //visible: (index < listView.model.count - 1) // 仅当前项不是最后一项时显示
                    visible: index==1||index==3
                }

                // 鼠标悬停时的背景色
                background: Rectangle {
                    color: hovered ? "lightgray" : "transparent" // 当鼠标悬停时变为灰色
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
