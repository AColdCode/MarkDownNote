import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import MarkDownNote  1.0

Window {
    id: openNotebookWindow
    width: 450
    height: 200
    minimumHeight: 200
    minimumWidth: 300
    title: qsTr("Open Notebook")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal
    property alias nameText: name_field.text
    property alias descText: desc_field.text
    property alias okEnable: ok_btn.enabled

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
                            id: name_field
                            Layout.fillWidth: true
                            placeholderText: qsTr("Name of notebook")
                            placeholderTextColor: "lightgray"
                            Layout.horizontalStretchFactor: 1
                            enabled: false
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
                            id: desc_field
                            Layout.fillWidth: true
                            placeholderTextColor: "lightgray"
                            placeholderText: qsTr("Description of notebook")
                            Layout.horizontalStretchFactor: 1
                            enabled: false
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
                            id: rootFolder_field
                            Layout.fillWidth: true
                            placeholderTextColor: "grey"
                            placeholderText: qsTr("Path of notebook root folder")
                            Layout.horizontalStretchFactor: 1

                            onTextChanged: {
                                MarkDownCtrl.noteBookCtrl.isLegalPath(rootFolder_field.text, openNotebookWindow)
                            }
                        }

                        Button {
                            text: qsTr("Browse")
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 0
                            onClicked: MarkDownCtrl.noteBookCtrl.selectRoot(rootFolder_field)
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
                id: ok_btn
                text: qsTr("Ok")
                icon.source: "qrc:/icons/Ok.svg"
                enabled: false
                onClicked: {
                    MarkDownCtrl.noteBookmodel.addNotebookByinfo(name_field.text, desc_field.text, rootFolder_field.text)
                    openNotebookWindow.close()
                }
            }
            Button {
                text: qsTr("Cancel")
                icon.source: "qrc:/icons/forbid.svg"
                onClicked: {
                    openNotebookWindow.close()
                }
            }
        }
    }

    onVisibleChanged: {
        if(visible) {
            name_field.clear()
            desc_field.clear()
            rootFolder_field.clear()
        }
    }

    onClosing: {
        openNotebookWindow.visible = false
    }
}
