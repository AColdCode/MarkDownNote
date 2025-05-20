import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import MarkDownNote 1.0

Window {
    id: notebookWindow
    width: 450
    height: 200
    minimumHeight: 200
    minimumWidth: 300
    title: qsTr("New Notebook")
    visible: false
    modality: Qt.ApplicationModal

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        color: "#f5f5f5"
        border.color: "gray"
        radius: 4

        ColumnLayout {
            width: parent.width
            spacing: 10

            GroupBox {
                title: qsTr("Basic Information")
                Layout.fillWidth: true
                Layout.margins: 5

                ColumnLayout {
                    spacing: 6
                    width: parent.width
                    // Name
                    RowLayout {
                        Layout.fillWidth: true

                        Label {
                            text: qsTr("Name") + ":"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 90
                            Layout.horizontalStretchFactor: 0
                        }

                        TextField {
                            Layout.fillWidth: true
                            placeholderText: qsTr("Name of notebook")
                            placeholderTextColor: "grey"
                            Layout.horizontalStretchFactor: 1
                        }
                    }

                    // Description
                    RowLayout {
                        Layout.fillWidth: true

                        Label {
                            text: qsTr("Description") + ":"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 90
                            Layout.horizontalStretchFactor: 0
                        }

                        TextField {
                            Layout.fillWidth: true
                            placeholderTextColor: "grey"
                            placeholderText: qsTr("Description of notebook")
                            Layout.horizontalStretchFactor: 1
                        }
                    }

                    // Root folder
                    RowLayout {
                        Layout.fillWidth: true

                        Label {
                            text: qsTr("Root folder") + ":"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 90
                            Layout.horizontalStretchFactor: 0
                        }

                        TextField {
                            id: pathField
                            Layout.fillWidth: true
                            placeholderTextColor: "grey"
                            placeholderText: qsTr("Path of notebook root folder")
                            Layout.horizontalStretchFactor: 1
                        }

                        Button {
                            text: qsTr("Browse")
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 0
                            onClicked: {
                                MarkDownCtrl.noteBookCtrl.selectRoot(pathField)
                            }
                        }
                    }
                }
            }
        }

        // 确定 / 取消按钮
        RowLayout {
            y: parent.height - height - 5
            x: parent.width - width - 5
            spacing: 10
            Button {
                text: qsTr("Ok")
                icon.source: "qrc:/icons/Ok.svg"
                onClicked: {
                    // 处理输入内容
                    notebookWindow.close()
                }
            }
            Button {
                text: qsTr("Cancel")
                icon.source: "qrc:/icons/forbid.svg"
                onClicked: {
                    notebookWindow.close()
                }
            }
        }
    }

    onClosing: {
        notebookWindow.visible = false
    }
}
