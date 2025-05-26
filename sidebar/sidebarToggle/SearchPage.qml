import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id:searchPage
    width: parent.width
    color:"transparent"

    property var searchHistory: ["无版本控制", "版本控制1", "版本控制2"]
    property bool suggestionsVisible: false
    ColumnLayout {
            anchors.fill: parent
            spacing: 10
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 5
                        Item {
                            width: searchPage.width-searchbutton.width*4-25
                            height: parent.height
                        }
                    Button {
                        id:searchbutton
                        onClicked: console.log("功能待实现")
                        icon.source: "qrc:/icons/search.svg"
                        icon.width:15
                        background: Rectangle {
                            color: parent.hovered ? "#e0e0e0": "transparent"
                        }
                        ToolTip {
                                parent: searchbutton
                                text: "搜索"
                                font.pointSize: 8
                                y:22
                                visible: searchbutton.hovered
                                delay: 300
                                padding: 4
                            }
                    }

                    Button {
                        id:discard_editor
                        onClicked: console.log("功能待实现")
                        icon.source: "qrc:/icons/discard_editor.svg"
                        icon.width:15
                        background: Rectangle {
                            color: parent.hovered ?  "#e0e0e0": "transparent"

                        }
                        ToolTip {
                                parent: discard_editor
                                text: "取消"
                                font.pointSize: 8
                                y:22
                                visible: discard_editor.hovered
                                delay: 300
                                padding: 4
                            }

                    }

                    Button {
                        id:location_list_dock
                        onClicked: console.log("功能待实现")
                        icon.source: "qrc:/icons/location_list_dock.svg"
                        icon.width:15
                        background: Rectangle {
                            color: parent.hovered ?  "#e0e0e0": "transparent"

                        }
                        ToolTip {
                                parent: location_list_dock
                                text: "打开或关闭列表位置"
                                font.pointSize: 8
                                y:22
                                visible: location_list_dock.hovered
                                delay: 300
                                padding: 4
                            }

                    }
                    Button {
                        id:advanced_settings
                        icon.source: "qrc:/icons/advanced_settings.svg"
                        icon.width:15
                        background: Rectangle {
                            color: parent.hovered ?  "#e0e0e0": "transparent"

                        }
                        ToolTip {
                                parent: advanced_settings
                                text: "高级设置"
                                font.pointSize: 8
                                y:22
                                visible: advanced_settings.hovered
                                delay: 300
                                padding: 4
                            }
                        onClicked: {
                            if(objectArea.visible!==false && goalArea.visible!==false)
                            {
                                objectArea.visible=false;
                                goalArea.visible=false;

                            }else{
                                objectArea.visible=true
                                goalArea.visible=true
                            }

                        }
                    }
                }
                ListModel {
                        id: suggestionsModel
                        Component.onCompleted: {
                            for (var i = 0; i < searchHistory.length; i++) {
                                append({text: searchHistory[i]})
                            }
                        }
                    }

                // 关键词输入区域
                RowLayout {
                    Layout.fillWidth: true
                    Label {
                        text: "关键词:"
                        padding: 2
                    }
                    ColumnLayout {
                            spacing: 10
                            Rectangle {
                                id: customInputBox
                                Layout.fillWidth: parent
                                height: 25
                                border.color:"lightgray"
                                border.width: 2
                                radius: 4
                                color: "#f0f0f0"
                                TextField {
                                    id: textField
                                    anchors.fill: parent
                                    placeholderText: "请输入搜索内容..."
                                    placeholderTextColor:"gray"
                                }

                                Button {
                                    id: clearButton
                                    anchors.right: dropDownButton.left
                                    anchors.rightMargin: 5
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 20
                                    height: 20
                                    background: Rectangle {
                                                    color: "transparent"
                                                    border.width: 0
                                    }
                                    icon.source: "qrc:/icons/reset.svg"
                                    visible: textField.text !== ""
                                    onClicked: {
                                        textField.text = ""
                                    }
                                }
                                Button {
                                    id: dropDownButton
                                    anchors.right: parent.right
                                    anchors.rightMargin: 5
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 20
                                    height: 20
                                    background: Rectangle {
                                                    color: "transparent"
                                                    border.width: 0
                                    }
                                    icon.source: "qrc:/icons/drop_down.svg"
                                    icon.color: "black"
                                    onClicked: popup.open()
                                }

                                Popup {
                                    id: popup
                                    y: customInputBox.height
                                    width: customInputBox.width
                                    height: listView.contentHeight+10
                                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                                    ListView {
                                        id:listView
                                        anchors.fill:parent
                                        model: suggestionsModel
                                        width: parent.width
                                        height: contentHeight
                                        delegate: ItemDelegate{
                                            width: parent.width
                                            height: 20
                                            RowLayout {
                                                spacing: 2
                                                Text {
                                                    id:textArea
                                                    text: model.text
                                                    font.pixelSize: 12
                                                    color: "black"
                                                    Layout.alignment: Qt.AlignVCenter
                                                }
                                            }
                                            // 鼠标悬停时的背景色
                                            background: Rectangle {
                                                color: hovered ? "lightgray" : "transparent"
                                            }

                                            MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                onClicked: {
                                                    textField.text = model.text
                                                    popup.close()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                }

            RowLayout {
                Layout.fillWidth: true
                Label {
                    id:label5
                    text: "范围:   "
                    padding: 2
                }
                ComboBox {
                    Layout.fillWidth: parent
                    model: ["缓冲区", "当前文件夹", "当前笔记本", "全部笔记本"]
                }
             }

            RowLayout{
                id:objectArea
                Layout.fillWidth: true
                Label{
                    text: "对象："
                    padding: 2

                }

                ColumnLayout {
                    Layout.fillWidth: true
                    RowLayout{
                        CheckBox {
                            text: "名字"
                        }
                        CheckBox {
                            text: "内容"
                        }
                    }

                    RowLayout{
                        CheckBox {
                            text: "标签"
                        }
                        CheckBox {
                            text: "路径"
                        }
                    }
                }
            }

            Rectangle {
                color: "lightgray"
                height: 1
                Layout.fillWidth: true
                Layout.leftMargin: 2
                Layout.rightMargin: 2
            }

            RowLayout{
                id:goalArea
                Layout.fillWidth: true
                Label{
                    text: "目标："
                    padding: 2

                }
                ColumnLayout {
                     Layout.fillWidth: true
                    RowLayout{
                        CheckBox {
                            text: "文件"
                        }
                        CheckBox {
                            text: "文件夹"
                        }
                    }
                    CheckBox {
                        text: "笔记本"
                    }
                }
            }

            Rectangle {
                color: "lightgray"
                height: 1
                Layout.fillWidth: true
                Layout.leftMargin: 2
                Layout.rightMargin: 2
            }

            // 目标选择区域
            RowLayout {
                Label {
                    text: "选项："
                    padding: 2
                }
                ColumnLayout {
                    RadioButton {
                        text: "大小写敏感（C)"
                    }
                    RadioButton {
                        text: "纯文本(p)"
                    }
                    RadioButton {
                        text: "匹配完整词(W)"
                    }
                    RadioButton {
                        text: "模糊搜索(F)"
                    }
                    RadioButton {
                        text: "正则表达式(G)"
                    }
                }

            }


            // 搜索结果区域
            GroupBox {
                title: "搜索结果："
                Layout.fillWidth: true
                Text {
                    text: "在这里显示搜索结果..."
                }
            }
            Item{
                Layout.fillHeight: true
            }
        }


    }
