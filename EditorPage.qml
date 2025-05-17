import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    property alias text: editor.text
    property alias font: editor.font

    ColumnLayout {
        anchors.fill: parent
        spacing: 1
        Rectangle{
            Layout.fillWidth: true
            height: 25
            Layout.fillHeight: true
            Layout.verticalStretchFactor: 0
            color: "#e0e0e0"
            RowLayout {
                anchors.fill: parent
                spacing: 5 // 可以调整间距

                // 中间空白区域
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                }

                // 第一个图标按钮
                Button {
                    Layout.fillHeight: true
                    background: Rectangle {
                        color: "transparent"
                    }
                    icon.source: "qrc:/icons/split_window_list.svg"
                    onClicked: console.log("Snippet Dock Clicked")
                }
                // 第二个图标按钮
                WorkspaceMenu{}
            }
        }

        Topbar{
            id:topbar
            Layout.fillWidth: true
            height: 25
            Layout.fillHeight: true
            Layout.verticalStretchFactor: 0
        }

        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.verticalStretchFactor: 1
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
