import QtQuick
import QtQuick.Controls
import MarkDownNote
import QtQuick.Layouts

Rectangle {
    id: resizableBox
    width: parent.width
    height: 150
    radius: 4


    property int windowHeight: parent.height
    property int minHeight: windowHeight*0.2
    property int maxHeight: windowHeight*0.7
    property real initialHeight
    property real dragStartY
    property int selectedRow: -1  // 当前选中行索引
    property int selectedSubIndex: -1  // 当前选中的子行索引（内容行）

    // 顶部拖动区域
    Rectangle {
        id: dragHandle
        anchors.top: parent.top
        width: parent.width
        height: 2
        color: "#e0e0e0"
        z: 1


        DragHandler {
            id: dragHandler
            yAxis.enabled: true
            xAxis.enabled: false
            onActiveChanged: if (active) {
                                resizableBox.dragStartY = centroid.scenePosition.y
                                 resizableBox.initialHeight = resizableBox.height
                 }

            onTranslationChanged: if (active) {
                                          const delta = centroid.scenePosition.y - resizableBox.dragStartY
                                          resizableBox.height = Math.max(
                                              Math.min(resizableBox.initialHeight - delta, resizableBox.maxHeight),
                                              resizableBox.minHeight
                                          )
                                          resizableBox.anchors.bottom = undefined
                                          resizableBox.y =windowHeight - resizableBox.height
             }
        }

        HoverHandler {
            cursorShape: Qt.SizeVerCursor
        }
    }

    // 主内容区域（使用ColumnLayout）
    ColumnLayout {
        anchors {
            top: dragHandle.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        spacing: 0

        // 标题栏区域
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "transparent"

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                // 第一行标题
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 25
                    color: "#e0e0e0"

                    RowLayout {
                        anchors.fill: parent
                        spacing: 0

                        Text {
                            text: "位置列表"
                            font.pixelSize: 12
                            Layout.leftMargin: 5
                        }

                        Item { Layout.fillWidth: true } // 占位

                        Button{
                            id:canclebutton
                            Layout.rightMargin: 5
                            icon.source: "qrc:/icons/close.svg"
                            icon.width:12
                            icon.height:12
                            Layout.alignment: Qt.AlignRight
                            background: Rectangle {
                                color: parent.hovered ? "lightgray": "transparent"


                            }
                            ToolTip {
                                    parent: canclebutton
                                    text: "关闭"
                                    font.pointSize: 8
                                    y:22
                                    visible: canclebutton.hovered
                                    delay: 300
                                    padding: 4
                                }
                            onClicked: {
                                resizableBox.visible=false
                            }
                        }
                    }
                }

                // 第二行计数
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 25
                    color: "#ededed"

                    RowLayout {
                        anchors.fill: parent
                        spacing: 10

                        Item { Layout.fillWidth: true } // 占位

                        Button{
                            id:clearbutton
                            onClicked: console.log("功能待实现")
                            icon.source: "qrc:/icons/clear.svg"
                            icon.width:15
                            Layout.alignment: Qt.AlignRight

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

                        Text {
                            text: noteModel.count+" 项"
                            font.pixelSize: 12
                            Layout.rightMargin: 10
                        }
                    }
                }
            }
        }

        // 表格区域
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Column {
                x:2
                width: parent.width-4
                height:parent.height


                Row {
                    width: parent.width
                    height: 20
                    spacing: 0
                    Rectangle {

                        width: parent.width * 0.2
                        height: parent.height
                        color: "transparent"
                        border.color: "lightgray"
                        border.width: 1

                        Text {
                            text: "路径"
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                            x: 10
                        }

                        Rectangle {
                            width: 3
                            height: parent.height
                            color: parent.border.color
                            anchors.left: parent.left
                        }

                        Rectangle {
                            width: parent.width
                            height: 3
                            color: parent.border.color
                            anchors.bottom: parent.bottom
                        }
                    }


                    Rectangle {
                        width: parent.width * 0.2
                        height: parent.height
                        color: "transparent"
                        border.width: 1
                        border.color: "lightgray"
                        Text {
                            text: "行号"
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                            x: 10
                        }
                        Rectangle {
                            width: parent.width
                            height: 3
                            color: parent.border.color
                            anchors.bottom: parent.bottom
                        }
                    }


                    Rectangle {
                        width: parent.width * 0.6
                        height: parent.height
                        color: "transparent"
                        border.width: 1
                        border.color: "lightgray"
                        Text {
                            text: "文本"
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                            x: 10
                        }
                        Rectangle {
                            width: 3
                            height: parent.height
                            color: parent.border.color
                            anchors.right: parent.right
                        }
                        Rectangle {
                            width: parent.width
                            height: 3
                            color: parent.border.color
                            anchors.bottom: parent.bottom
                        }
                    }
                }


                // 数据模型
                ListModel {
                    id: noteModel
                    ListElement {
                        path: "笔记1..."  // 路径显示
                        expanded: false   // 初始折叠状态
                        entries: [
                            ListElement { line: "2"; text: "9vsdf" },
                            ListElement { line: "4"; text: "Sklml" },
                            ListElement { line: "6"; text: "hgss" },
                            ListElement { line: "7"; text: "nss" },
                            ListElement { line: "8"; text: "yyss" },
                            ListElement { line: "9"; text: "9vsdf" },
                            ListElement { line: "11"; text: "Sklml" },
                            ListElement { line: "13"; text: "hgss" },
                            ListElement { line: "14"; text: "nss" },
                            ListElement { line: "15"; text: "yyss" },
                            ListElement { line: "16"; text: "9vsdf" }
                        ]
                    }
                    ListElement{
                                path: "笔记2..."  // 路径显示
                                expanded: false   // 初始折叠状态
                                entries: [
                                    ListElement { line: "2"; text: "9vsdf" },
                                    ListElement { line: "4"; text: "Sklml" },
                                    ListElement { line: "6"; text: "hgss" },
                                    ListElement { line: "7"; text: "nss" },
                                    ListElement { line: "8"; text: "yyss" },
                                    ListElement { line: "9"; text: "9vsdf" },
                                    ListElement { line: "11"; text: "Sklml" },
                                    ListElement { line: "13"; text: "hgss" },
                                    ListElement { line: "14"; text: "nss" },
                                    ListElement { line: "15"; text: "yyss" },
                                    ListElement { line: "16"; text: "9vsdf" }
                                ]
                            }
                    ListElement{
                                path: "笔记3..."  // 路径显示
                                expanded: false   // 初始折叠状态
                                entries: [
                                    ListElement { line: "2"; text: "9vsdf" },
                                    ListElement { line: "4"; text: "Sklml" },
                                    ListElement { line: "6"; text: "hgss" },
                                    ListElement { line: "7"; text: "nss" },
                                    ListElement { line: "8"; text: "yyss" },
                                    ListElement { line: "9"; text: "9vsdf" },
                                    ListElement { line: "11"; text: "Sklml" },
                                    ListElement { line: "13"; text: "hgss" },
                                    ListElement { line: "14"; text: "nss" },
                                    ListElement { line: "15"; text: "yyss" },
                                    ListElement { line: "16"; text: "9vsdf" }
                                ]
                            }
                    // 可以添加更多路径组...
                }

                // 主表格区域
                ColumnLayout {
                    width: parent.width
                    height: parent.height - 30
                    anchors.margins: 10
                    spacing: 0

                    // 表格内容
                    ListView {
                        id: positionTable
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        model: noteModel
                        spacing: 1

                        delegate: ColumnLayout {
                            width: positionTable.width
                            spacing: 1

                            // 路径行（单独显示）
                            Rectangle {
                                Layout.fillWidth: true
                                height: 20
                                color: {
                                        if (selectedRow === index && selectedSubIndex === -1) return "#e0e0e0"; // 选中路径行
                                        else if (contentMouse.pressed) return "#d0d0d0";
                                        else if (contentMouse.containsMouse) return "#f5f5f5";
                                        else return expanded ? "#f0f0f0" : "white";
                                    }
                                Behavior on color { ColorAnimation { duration: 100 } } // 平滑过渡
                                MouseArea {
                                    id: contentMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        // 如果点击的是已展开的行，则只更新选中状态
                                        if (expanded) {
                                            selectedRow = index;
                                            selectedSubIndex = -1;
                                        }
                                        // 如果点击的是未展开的行，则先折叠所有其他行，再展开当前行
                                        else {
                                            // 重置所有行的expanded状态
                                            for (var i = 0; i < noteModel.count; i++) {
                                                noteModel.setProperty(i, "expanded", false);
                                            }
                                            // 展开当前行并选中
                                            noteModel.setProperty(index, "expanded", true);
                                            selectedRow = index;
                                            selectedSubIndex = -1; // 重置内容行选中状态
                                        }
                                    }
                                }

                                RowLayout {
                                    anchors.fill: parent
                                    spacing: 0

                                    // 下拉箭头（占位）
                                    Label {
                                        text: expanded ? "▼" : "▶"
                                        font.pixelSize: 12
                                        Layout.preferredWidth: 20
                                        horizontalAlignment: Text.AlignHCenter

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: noteModel.setProperty(index, "expanded", !expanded)
                                        }
                                    }
                                    Image {
                                        Layout.preferredWidth: 15
                                        Layout.preferredHeight: 15
                                        source: "qrc:/icons/buffer.svg"
                                    }


                                    // 路径文本（单独显示）
                                    Label {
                                        text: path
                                        Layout.preferredWidth: parent.width * 0.2 - 20
                                        leftPadding: 5
                                        font.pixelSize:12
                                        elide: Text.ElideRight
                                    }

                                    // 空列（行号）
                                    Label {
                                        text: ""
                                        font.pixelSize:12
                                        Layout.preferredWidth: parent.width * 0.2
                                    }

                                    // 空列（文本）
                                    Label {
                                        text: ""
                                        font.pixelSize:12
                                        Layout.preferredWidth: parent.width * 0.6
                                    }
                                }
                            }

                            // 内容行（条件显示）
                            Repeater {
                                model: expanded ? entries : 0
                                delegate: Rectangle {
                                    width: positionTable.width
                                    height: 20
                                    color: {
                                            if (selectedRow === index && selectedSubIndex === model.index) return "#e0e0e0"; // 选中内容行
                                            else if (rowMouse.pressed) return "#d0d0d0";
                                            else if (rowMouse.containsMouse) return "#f5f5f5";
                                            else return "white";
                                        }
                                    Behavior on color { ColorAnimation { duration: 100 } }
                                    MouseArea {
                                        id: rowMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            selectedRow = index;
                                            selectedSubIndex = model.index; // 记录子行索引
                                        }
                                    }
                                    Row {
                                        anchors.fill: parent
                                        spacing: 0

                                        // 路径占位（保持对齐）
                                        Label {
                                            width: parent.width * 0.2
                                            height: parent.height
                                            font.pixelSize:12
                                            text: ""
                                        }

                                        // 行号
                                        Label {
                                            width: parent.width * 0.2
                                            height: parent.height
                                            text: model.line
                                            font.pixelSize:12
                                            leftPadding: 25
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        // 文本内容
                                        Label {
                                            width: parent.width * 0.6
                                            height: parent.height
                                            text: model.text
                                            font.pixelSize:12
                                            leftPadding: 5
                                            verticalAlignment: Text.AlignVCenter
                                            color: ["vsdf","klml","hgss"].some(v => model.text.includes(v)) ?
                                                  "#2e7d32" : "black"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        MarkDownCtrl.sidebarCtrl.resizableBox=resizableBox;
    }
}
