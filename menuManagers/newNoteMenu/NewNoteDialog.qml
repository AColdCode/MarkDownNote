import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

Window {
    id: noteWindow
    width: 300
    height: 200
    minimumHeight: 200
    minimumWidth: 300
    title: qsTr("New Note")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        color: "#f5f5f5"
        border.color: "gray"
        radius: 4

        GroupBox {
            anchors.fill: parent

            ColumnLayout {
                spacing: 6
                width: parent.width
                // Notebook
                RowLayout {
                    Layout.fillWidth: true

                    Label {
                        text: qsTr("Notebook") + ":"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 90
                        Layout.horizontalStretchFactor: 0
                    }

                    Label {
                        id: notebook
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
                    }
                }

                // Location
                RowLayout {
                    Layout.fillWidth: true

                    Label {
                        text: qsTr("Location") + ":"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 90
                        Layout.horizontalStretchFactor: 0
                    }

                    Label {
                        id: location
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
                    }

                    Button {
                        id: up_folder
                        icon.source: "qrc:/icons/up_level.svg"
                        text: qsTr("Up")
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 0
                    }
                }

                // File type
                RowLayout {
                    Layout.fillWidth: true

                    Label {
                        text: qsTr("File type") + ":"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 90
                        Layout.horizontalStretchFactor: 0
                    }

                    ComboBox {
                        id: filetype_combo
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
                        model: ["Markdown", "Text", "Mind Map", "Others"]
                        currentIndex: 0
                    }
                }

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
                        id: filename
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
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
                    noteWindow.close()
                }
            }
            Button {
                text: qsTr("Cancel")
                icon.source: "qrc:/icons/forbid.svg"
                onClicked: {
                    noteWindow.close()
                }
            }
        }
    }

    onClosing: {
        noteWindow.visible = false
    }
}
