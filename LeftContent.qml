import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "leftContent"
import MarkDownNote 1.0

ColumnLayout {
    spacing: 0

    Rectangle {
        Layout.fillWidth: true
        height: 26
        Layout.fillHeight: true
        Layout.verticalStretchFactor: 0
        color: "#e0e0e0"

        RowLayout {
            id: tabBar
            anchors.fill: parent
            spacing: 0 // 可以调整间距

            FileNameTabs {
                id: tabBarNames
                clip: true
                Layout.fillHeight: true
                Layout.fillWidth: true
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

    StackLayout {
        id: tabStack
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.verticalStretchFactor: 1
        currentIndex: tabBarNames.currentIndex

        Repeater {
            id: editor_repeater
            model: MarkDownCtrl.editorModel

            ColumnLayout {
                width: parent.width
                height: parent.height
                spacing: 0
                property alias textArea: editor.textArea

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
                        visible: topbar.editorPageVisible
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
        }

        Connections {
            target: MarkDownCtrl.editorModel

            function onCountChanged(newCount) {
                Qt.callLater(() => {
                    tabBarNames.currentIndex = newCount - 1
                })
            }
        }

        Connections {
            target: MarkDownCtrl.editorModel

            function onFrontEditorClosed() {
                Qt.callLater(() => {
                    tabBarNames.currentIndex = tabBarNames.currentIndex - 1
                })
            }
        }

        Connections {
            target: MarkDownCtrl.editorModel

            function onFirstEditorClose() {
                Qt.callLater(() => {
                    tabBarNames.currentIndex = 0
                })
            }
        }

        onCurrentIndexChanged: {
            if(currentIndex >= 0) {
                MarkDownCtrl.topbarCtrl.textArea = editor_repeater.itemAt(currentIndex).textArea
            }else {
                MarkDownCtrl.topbarCtrl.textArea = null
            }
        }
    }

    Component.onCompleted: {
        MarkDownCtrl.tabBarNames = tabBarNames
    }
}
