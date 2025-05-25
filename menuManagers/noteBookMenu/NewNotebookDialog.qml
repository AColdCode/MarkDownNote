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
            height: parent.height
            spacing: 0

            GroupBox {
                title: qsTr("Basic Information")
                Layout.fillWidth: true
                Layout.fillHeight: true
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
                            placeholderTextColor: "grey"
                            Layout.horizontalStretchFactor: 1

                            onAccepted: {
                                ok_btn.clicked()
                            }
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
                            placeholderTextColor: "grey"
                            placeholderText: qsTr("Description of notebook")
                            Layout.horizontalStretchFactor: 1

                            onAccepted: {
                                ok_btn.clicked()
                            }
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

                            onAccepted: {
                                ok_btn.clicked()
                            }
                        }

                        Button {
                            text: qsTr("Browse")
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 0
                            onClicked: {
                                MarkDownCtrl.noteBookCtrl.selectRoot(rootFolder_field)
                            }
                        }
                    }
                }
            }

            // hint Area
            Rectangle {
                Layout.fillWidth: true
                Layout.margins: 5
                height: 90
                border.color: "green"
                visible: hint_area.text !== ""

                TextArea {
                    id: hint_area
                    anchors.fill: parent
                    wrapMode: TextArea.Wrap
                    readOnly: true
                }
            }

            // 确定 / 取消按钮
            RowLayout {
                Layout.fillWidth: true
                Layout.margins: 5
                spacing: 10

                Item {
                    Layout.fillWidth: true
                }

                Button {
                    id: ok_btn
                    text: qsTr("Ok")
                    icon.source: "qrc:/icons/Ok.svg"
                    onClicked: {
                        var flag = MarkDownCtrl.noteBookmodel.addNotebookByinfo(name_field.text, desc_field.text, rootFolder_field.text, hint_area)
                        if(flag)
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
    }

    onVisibleChanged: {
        if(visible) {
            name_field.clear()
            desc_field.clear()
            rootFolder_field.clear()
        }
    }

    onClosing: {
        notebookWindow.visible = false
    }
}
