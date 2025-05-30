import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import MarkDownNote 1.0

Window {
    id: notebookWindow_folder
    width: 450
    height: 450
    minimumHeight: 450
    minimumWidth: 450
    title: qsTr("New Notebook From Folder")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal

    property string hintText: ""
    property bool okEnable: false
    property string pathText: ""
    property alias nameText: name_filed.text

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

            // Source Folder
            GroupBox {
                title: qsTr("Source Folder")
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.verticalStretchFactor: 1
                Layout.margins: 5

                ColumnLayout {
                    spacing: 6
                    width: parent.width
                    height: parent.height
                    // Folder
                    RowLayout {
                        Layout.fillWidth: true
                        Label {
                            text: qsTr("Folder") + ":"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 90
                            Layout.horizontalStretchFactor: 0
                        }

                        TextField {
                            id: pathField
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 1

                            onAccepted: {
                                okEnable = false
                                MarkDownCtrl.noteBookCtrl.newFromFolder(pathField.text, notebookWindow_folder)
                                MarkDownCtrl.noteBookmodel.isExistNotebook(pathField.text, notebookWindow_folder)
                            }
                        }

                        Button {
                            text: qsTr("Browse")
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 0

                            onClicked: MarkDownCtrl.noteBookCtrl.selectRoot(pathField, true)
                        }
                    }

                    // Select files
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Label {
                            text: qsTr("Select files") + ":"
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.minimumWidth: 90
                            Layout.horizontalStretchFactor: 0
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.horizontalStretchFactor: 1
                            height: selectAll_btn.height * 2
                            color: "lightgray"
                            clip: true

                            ScrollView {
                                anchors.fill: parent

                                ListView {
                                    id: suffixeListView
                                    width: parent.width
                                    spacing: 5
                                    model: MarkDownCtrl.noteBookCtrl.suffixListModel
                                    delegate: CheckBox {
                                        id: suffixCheck
                                        text: suffix
                                        checked: model.checked
                                        onCheckedChanged: MarkDownCtrl.noteBookCtrl.suffixListModel.setChecked(index, suffixCheck.checked)
                                    }
                                }
                            }
                        }


                        ColumnLayout{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.horizontalStretchFactor: 0
                            Button {
                                id: selectAll_btn
                                text: qsTr("Select All")
                                onClicked: {
                                    for (var i = 0; i < suffixeListView.count; i++) {
                                        MarkDownCtrl.noteBookCtrl.suffixListModel.setChecked(i, true)
                                    }
                                }
                            }
                            Button {
                                id: clear_btn
                                text: qsTr("Clear")
                                onClicked: {
                                    for(var i = 0; i < suffixeListView.count; i++){
                                        MarkDownCtrl.noteBookCtrl.suffixListModel.setChecked(i, false)
                                    }
                                }
                            }

                            Item {
                                Layout.fillHeight: true
                            }
                        }
                    }
                }
            }

            // Basic Information
            GroupBox {
                title: qsTr("Basic Information")
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.verticalStretchFactor: 1
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
                            Layout.minimumWidth: 90
                            Layout.horizontalStretchFactor: 0
                        }

                        TextField {
                            id: name_filed
                            Layout.fillWidth: true
                            placeholderText: qsTr("Name of notebook")
                            placeholderTextColor: "grey"
                            Layout.horizontalStretchFactor: 1

                            onTextChanged: {
                                if(text === ""){
                                    hintText = qsTr("Please specify a name for the notebook.")
                                }
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
                            Layout.fillWidth: true
                            placeholderTextColor: "grey"
                            placeholderText: qsTr("Path of notebook root folder")
                            Layout.horizontalStretchFactor: 1
                            readOnly: true
                            text: pathText
                        }
                    }
                }
            }

            // hint Area
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.verticalStretchFactor: 0
                Layout.margins: 5
                height: 90
                border.color: "green"
                visible: hint_area.text !== ""

                TextArea {
                    id: hint_area
                    anchors.fill: parent
                    wrapMode: TextArea.Wrap
                    readOnly: true
                    text: hintText
                }
            }

            // 确定 / 取消按钮
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.verticalStretchFactor: 0
                Layout.margins: 5
                spacing: 10

                Item {
                    Layout.fillWidth: true
                }

                Button {
                    id: ok_btn
                    text: qsTr("Ok")
                    icon.source: "qrc:/icons/Ok.svg"
                    enabled: okEnable
                    onClicked: {
                        MarkDownCtrl.noteBookmodel.newNoteBookFromFolder(nameText, desc_field.text, pathText, MarkDownCtrl.noteBookCtrl.suffixListModel.selectedSuffixes())
                        notebookWindow_folder.close()
                    }
                }
                Button {
                    text: qsTr("Cancel")
                    icon.source: "qrc:/icons/forbid.svg"
                    onClicked: {
                        notebookWindow_folder.close()
                    }
                }
            }
        }
    }

    onClosing: {
        notebookWindow_folder.visible = false
    }
}
