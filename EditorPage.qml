import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    width: 400
    height: parent.height
    property alias text: editor.text
    property alias font: editor.font

    Rectangle {
        width: 400
        height: parent.height
        Column{
            anchors.fill: parent
            spacing: 1
            Rectangle{
                width: 400
                height: 25
                color: "#efeded"
                Row {
                        anchors.fill: parent
                        spacing: 5

                        // 中间空白区域
                        Rectangle {
                            width: parent.width*0.8
                            height: parent.height
                            color: "transparent"
                        }

                        // 第一个图标按钮
                        Button {
                            width: parent.width * 0.08
                            height: parent.height
                            background: Rectangle {
                                color: "transparent"
                            }
                            contentItem: Image {
                                source: "qrc:/icons/split_window_list.svg"
                                fillMode: Image.PreserveAspectFit
                                width: parent.width * 0.8
                                height: width
                            }
                            onClicked: console.log("Snippet Dock Clicked")
                        }

                        WorkspaceMenu{}
                    }

            }

            Topbar{
                id:topbar
                Layout.fillWidth: true
                Layout.fillHeight: true

            }

            Rectangle{
                width: parent.width
                height: parent.height-50
                color:"#eeeeee"

                TextArea {
                    id:editor
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    wrapMode: TextEdit.Wrap
                    text: "##Hello Markdown"
                    onTextChanged: console.log("Text changed:", text)
                }

        }
        }
    }
}
