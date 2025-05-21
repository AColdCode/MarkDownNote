import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import MarkDownNote 1.0

Window {
    id: notebookWindow
    width: 450
    height: 300
    minimumHeight: 300
    minimumWidth: 400
    title: qsTr("Manage Notebooks")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal
    color: "#f5f5f5"


    ColumnLayout {
        width: parent.width
        height: parent.height

        RowLayout {
            width: parent.width
            spacing: -15
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 3
                Layout.margins: 10
                color: "white"
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 5
                Layout.margins: 10
                color: "#f5f5f5"
                border.color: "gray"

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
                                    onClicked: MarkDownCtrl.noteBookCtrl.selectRoot(pathField)
                                }
                            }
                        }
                    }
                }

                // 关闭/删除按钮
                RowLayout {
                    y: parent.height - height - 5
                    x: parent.width - width - 5
                    spacing: 10
                    Button {
                        text: qsTr("Close Notebook")
                        onClicked: {
                            // 处理输入内容
                            notebookWindow.close()
                        }
                    }
                    Button {
                        text: qsTr("Delete")
                        onClicked: {
                            notebookWindow.close()
                        }
                    }
                }
            }
        }

        RowLayout {
            width: parent.width
            Layout.bottomMargin: 10
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            Button {
                text: qsTr("Reset")
                icon.source: "qrc:/icons/reset.svg"
            }

            Item {
                id: name
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("OK")
                icon.source: "qrc:/icons/Ok.svg"
            }

            Button {
                text: qsTr("Apply")
                icon.source: "qrc:/icons/Ok.svg"
            }

            Button {
                text: qsTr("Cancel")
                icon.source: "qrc:/icons/forbid.svg"
            }
        }
    }

    onClosing: {
        notebookWindow.visible = false
    }
}
