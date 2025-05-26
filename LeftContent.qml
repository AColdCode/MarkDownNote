import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "leftContent"

ColumnLayout {
    spacing: 0

    Rectangle {
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

    Topbar {
        id:topbar
        Layout.fillWidth: true
        height: 25
        Layout.fillHeight: true
        Layout.verticalStretchFactor: 0
    }

    RowLayout {
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.verticalStretchFactor: 1

        EditorPage {
            id: editor
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pixelSize: 18
            Layout.horizontalStretchFactor: 1
        }

        PreviewPage {
            id: preview
            Layout.fillWidth: true
            Layout.fillHeight: true
            markdownText: editor.text
            Layout.horizontalStretchFactor: 1
        }
    }
}
