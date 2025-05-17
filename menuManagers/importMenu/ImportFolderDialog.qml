import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

Window {
    id: importFolderWindow
    width: 450
    height: 200
    minimumHeight: 200
    minimumWidth: 300
    title: qsTr("Import Folder")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal
    property string filepath: ""

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        color: "#f5f5f5"
        border.color: "gray"
        radius: 4

        GroupBox {
            anchors.fill: parent
            Layout.margins: 5

            ColumnLayout {
                spacing: 6
                width: parent.width
                height: parent.height - 50
                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.verticalStretchFactor: 0

                    Label {
                        text: qsTr("Import folder into") + "(" + importFolderWindow.filepath + ")."
                        Layout.fillWidth: true
                        Layout.minimumWidth: 90
                        Layout.horizontalStretchFactor: 0
                    }
                }

                // Folder
                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.verticalStretchFactor: 0

                    Label {
                        text: qsTr("Folder") + ":"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 90
                        Layout.horizontalStretchFactor: 0
                    }

                    TextField {
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
                        enabled: false
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
                    Layout.fillHeight: true
                    Layout.verticalStretchFactor: 1

                    Label {
                        text: qsTr("Select files") + ":"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 90
                        Layout.fillHeight: true
                        Layout.horizontalStretchFactor: 0
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
                        Layout.fillHeight: true
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

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.horizontalStretchFactor: 0
                        Button {
                            id: selectAll_btn
                            text: qsTr("Select All")
                        }
                        Button {
                            id: clear_btn
                            text: qsTr("Clear")
                        }
                        Item {
                            Layout.fillHeight: true
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
                    importFolderWindow.close()
                }
            }
            Button {
                text: qsTr("Cancel")
                icon.source: "qrc:/icons/forbid.svg"
                onClicked: {
                    importFolderWindow.close()
                }
            }
        }
    }

    onClosing: {
        importFolderWindow.visible = false
    }
}
