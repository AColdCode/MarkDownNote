import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: manageNotebookDialog
    width: 500; height: 600
    title: qsTr("管理笔记本")
    visible: false
    color: "#efeded"
    flags: Qt.Window | Qt.WindowTitleHint | Qt.WindowCloseButtonHint | Qt.WindowMinMaxButtonsHint


    // 内容区域
    Row{
        anchors.top:parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: footer.top
        spacing: 10
        padding: 10


        Rectangle{
            id:notebookView
            width: (parent.width-30)*0.25
            height: parent.height-20
            color:"white"
            ListView {
                id: listView
                width: parent.width
                height: contentHeight
                model: ListModel {
                       ListElement { name: "ttt"; checked: true }
                       ListElement { name: "sss"; checked: false}
                       ListElement { name: "新建工作空间"; checked: false}

                   }

                property int selectedIndex: 0 // 默认选中的索引

                delegate: ItemDelegate {
                    width: parent.width
                    height: text.height+5

                    Row {
                        spacing: 5
                        Text {
                            id:text
                            y:3
                            text: model.name
                            font.pixelSize: 12
                            color: "black"
                            Layout.alignment: Qt.AlignVCenter // 垂直居中对齐
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

        Rectangle{
            id:dataDisplay
            width: (parent.width-30)*0.75
            height: parent.height-20
            color:"transparent"
            border.width: 2
            border.color: "lightgray"

            Column {
                        anchors.fill: dataDisplay
                        spacing: 5
                        padding: 5
                        Label {
                            id:text1
                            text: qsTr("基本信息")
                            font.bold: true
                        }

                        // 基本信息部分
                        Rectangle {
                            id:basicshow
                            y:5
                            width:parent.width-20
                            height: (parent.height-text1.height-text2.height-35-dataViewbottom.height)/2
                            color: "#f0f0f0"
                            border.width: 1
                            border.color: "lightgray"

                            Column{
                                anchors.fill: parent
                                padding: 10
                                spacing: 10

                                Row {
                                    spacing: 10
                                    Label {
                                        id:label0
                                        text: "类型:      "
                                        width: 80
                                        horizontalAlignment: Qt.AlignLeft
                                    }
                                    ComboBox {
                                        width:basicshow.width-label0.width-25


                                        model: ["自包含笔记本", "其他类型"]
                                    }
                                }

                                Row{
                                    spacing: 10
                                    Label {
                                        id:label1
                                        text: "名字:      "
                                        width: 80
                                        horizontalAlignment: Qt.AlignLeft
                                    }
                                    TextField {
                                        width:basicshow.width-label1.width-25
                                        placeholderTextColor: "black"

                                        placeholderText: "ss"
                                    }
                                }

                                Row{
                                    spacing: 10
                                    Label {
                                        id:label2
                                        text: "图标:      "
                                        width: 80
                                        horizontalAlignment: Qt.AlignLeft
                                    }
                                    TextField {
                                        width:basicshow.width-label2.width-25
                                        placeholderTextColor: "black"
                                        placeholderText: qsTr("default")
                                    }
                                }

                                Row {
                                    spacing: 10
                                    Label {
                                        id:label3
                                        text: "描述:"
                                        width: 80
                                        horizontalAlignment: Qt.AlignLeft
                                    }
                                    TextField {
                                        width:basicshow.width-label3.width-25
                                        placeholderTextColor: "black"
                                        placeholderText: qsTr("笔记本描述")
                                    }
                                }

                                Row{
                                    spacing: 10
                                    Label {
                                        id:label4
                                        text: "根文件夹:"
                                        width: 80
                                        horizontalAlignment: Qt.AlignLeft
                                    }
                                    TextField {
                                        width:basicshow.width-label4.width-25
                                        placeholderTextColor: "black"

                                        placeholderText: "/root/Zy/Vnote笔记本2"
                                    }
                                }
                            }
                        }

                        Label {
                            id:text2
                            text: qsTr("高级信息")
                            font.bold: true
                        }

                        // 高级信息部分
                        Rectangle {
                            width:parent.width-20
                            height: (parent.height-text1.height-text2.height-35-dataViewbottom.height)/2
                            color: "#f0f0f0"
                            border.width: 1
                            border.color: "lightgray"



                            Column {
                               anchors.fill: parent
                                padding: 10
                                spacing: 10


                                Row {
                                    spacing: 10
                                    Label {
                                        id:label5
                                        text: "配置管理器:"
                                        width: 80
                                        horizontalAlignment: Qt.AlignLeft
                                    }
                                    ComboBox {
                                        width:basicshow.width-label5.width-25
                                        model: ["VNoteX Notebook Configuration", "其他配置"]
                                    }
                                }

                                Row {
                                    spacing: 10
                                    Label {
                                        id:label6
                                        text: "版本管理:   "
                                        width: 80
                                        horizontalAlignment: Qt.AlignLeft
                                    }
                                    ComboBox {
                                        width:basicshow.width-label6.width-25
                                        model: ["无版本控制", "有版本控制"]
                                    }
                                }

                                Row {
                                    spacing: 10
                                    Label {
                                        id:label7
                                        text: "后端:         "
                                        width: 80
                                        horizontalAlignment: Qt.AlignLeft
                                    }
                                    ComboBox {
                                        width:basicshow.width-label7.width-25
                                        model: ["本地笔记本后端", "远程后端"]
                                    }
                                }
                            }
                        }
                    }


                    // 底部按钮区域
                    Rectangle{
                        id:dataViewbottom
                        anchors.bottom: dataDisplay.bottom
                        anchors.left: dataDisplay.left
                        anchors.right: dataDisplay.right
                        height: 30
                        color:"transparent"
                        anchors.margins:1


                    Row{
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        spacing: 10
                        anchors.margins: 10

                        Button {
                            text: qsTr("关闭笔记本")
                            onClicked: {
                                console.log("关闭笔记本按钮被点击");
                            }
                        }

                        Button {
                            text: qsTr("删除")
                            onClicked: {
                                console.log("删除按钮被点击");
                            }
                        }
                    }
                }

        }
    }

    // 底部按钮区域
    Frame {
        id: footer
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        Layout.alignment: Qt.AlignBottom


        RowLayout {
            anchors.fill: parent
            spacing: 10

            Button {
                icon.source: "qrc:/icons/reset.svg"
                text: "重置"
            }

            Item {
                Layout.fillWidth: true
            }

            Button {
                icon.source: "qrc:/icons/Ok.svg"
                id:surebutton
                text: "确定"

            }

            Button {
                icon.source: "qrc:/icons/Ok.svg"
                id:applybotton
                text: "应用"

            }
            Button {
                id:cancelbutton
                icon.source: "qrc:/icons/forbid.svg"
                icon.color:"black"
                text: "取消"
                onClicked: manageNotebookDialog.close()


            }
        }

    }
}


