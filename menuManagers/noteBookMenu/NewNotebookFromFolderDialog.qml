import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

Window {
    id: notebookWindow_folder
    width: 450
    height: 350
    minimumHeight: 350
    minimumWidth: 300
    title: qsTr("New Notebook From Folder")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
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

            // Source Folder
            GroupBox {
                title: qsTr("Source Folder")
                Layout.fillWidth: true
                Layout.margins: 5

                ColumnLayout {
                    spacing: 6
                    width: parent.width
                    // Folder
                    RowLayout {
                        Layout.fillWidth: true

                        Label {
                            text: qsTr("Folder") + ":"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 90  // 设置一个合理的最小宽度
                            Layout.horizontalStretchFactor: 0
                        }

                        TextField {
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 1
                        }

                        Button {
                            text: qsTr("Browse")
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 0
                        }
                    }

                    // Select files
                    RowLayout {
                        Layout.fillWidth: true

                        Label {
                            text: qsTr("Select files") + ":"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 90
                            Layout.horizontalStretchFactor: 0
                        }

                        Rectangle{
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 1
                            height: selectAll_btn.height * 2
                            color: "lightgray"
                            clip: true

                            ScrollView {
                                anchors.fill: parent

                                ListView {
                                    width: parent.width
                                    spacing: 5
                                    model: [
                                        "md", "zip", "txt"
                                    ]

                                    delegate: CheckBox {
                                        text: modelData
                                        checked: false
                                    }
                                }
                            }
                        }


                        ColumnLayout{
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 0
                            Button {
                                id: selectAll_btn
                                text: qsTr("Select All")
                            }
                            Button {
                                id: clear_btn
                                text: qsTr("Clear")
                            }
                        }
                    }
                }
            }

            // Basic Information
            GroupBox {
                title: qsTr("Basic Information")
                Layout.fillWidth: true
                Layout.margins: 15

                ColumnLayout {
                    spacing: 6
                    width: parent.width
                    // Name
                    RowLayout {
                        Layout.fillWidth: true

                        Label {
                            text: qsTr("Name") + ":"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 90  // 设置一个合理的最小宽度
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
                onClicked: {
                    // 处理输入内容
                    notebookWindow_folder.close()
                }
            }
            Button {
                text: qsTr("Cancel")
                onClicked: {
                    notebookWindow_folder.close()
                }
            }
        }
    }

    onClosing: {
        notebookWindow_folder.visible = false
    }
}
