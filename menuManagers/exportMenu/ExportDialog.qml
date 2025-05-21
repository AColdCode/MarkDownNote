import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

import MarkDownNote 1.0

Window {
    id: notebookWindow
    width: 450
    height: 400
    minimumHeight: 200
    minimumWidth: 300
    title: qsTr("Export")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal
    property string currentFile: ""
    property string currentFolder: ""

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        color: "#f5f5f5"
        border.color: "gray"
        radius: 4

        ColumnLayout {
            anchors.fill: parent
            ScrollView {
                id: scrollview_groups
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    width: scrollview_groups.width
                    height: scrollview_groups.height
                    spacing: 10

                    // Source
                    GroupBox {
                        title: qsTr("Source")
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.margins: 5
                        Layout.minimumHeight: 70

                        RowLayout {
                            width: parent.width

                            Label {
                                text: qsTr("Source") + ":"
                                Layout.fillWidth: true
                                Layout.minimumWidth: 90
                                Layout.horizontalStretchFactor: 0
                            }

                            ComboBox {
                                id: source_combo
                                Layout.fillWidth: true
                                Layout.horizontalStretchFactor: 1
                                model: ListModel {
                                     id: valueModel
                                 }
                            }
                        }
                    }

                    // Target
                    GroupBox {
                        title: qsTr("Target")
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.margins: 5
                        Layout.minimumHeight: 100

                        ColumnLayout {
                            width: parent.width

                            // Format
                            RowLayout {
                                Layout.fillWidth: true

                                Label {
                                    text: qsTr("Format") + ":"
                                    Layout.fillWidth: true
                                    Layout.minimumWidth: 90
                                    Layout.horizontalStretchFactor: 0
                                }

                                ComboBox {
                                    id: format_combo
                                    Layout.fillWidth: true
                                    Layout.horizontalStretchFactor: 0

                                    model: ListModel {
                                         ListElement { text: "Markdown" }
                                         ListElement { text: "HTML" }
                                         ListElement { text: "PDF" }
                                     }
                                }
                            }

                            // Output directory
                            RowLayout {
                                Layout.fillWidth: true

                                Label {
                                    text: qsTr("Output directory") + ":"
                                    Layout.fillWidth: true
                                    Layout.minimumWidth: 90
                                    Layout.horizontalStretchFactor: 0
                                }

                                TextField {
                                    id: folderPath_field
                                    Layout.fillWidth: true
                                    Layout.horizontalStretchFactor: 1
                                }

                                Button {
                                    text: qsTr("Browse")
                                    Layout.fillWidth: true
                                    Layout.horizontalStretchFactor: 0

                                    onClicked: {
                                        MarkDownCtrl.exportMenuCtrl.selectFolder(folderPath_field)
                                    }
                                }
                            }
                        }
                    }

                    // Advanced
                    GroupBox {
                        title: qsTr("Advanced")
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.margins: 5
                        Layout.minimumHeight: 100

                        ColumnLayout {
                            width: parent.width

                            CheckBox {
                                id: dealSub_folders
                                text: qsTr("Process sub-folders")
                                checked: true
                            }

                            CheckBox {
                                id: export_attachments
                                text: qsTr("Export attachments")
                                checked: true
                            }
                        }
                    }
                }
            }

            // ouput
            Rectangle {
                Layout.fillWidth: true
                Layout.margins: 5
                height: 100
                visible: false
                border.color: "green"

                ScrollView {
                    anchors.fill: parent
                    TextArea {
                        id: editor
                        wrapMode: TextArea.Wrap
                        font.pixelSize: 16
                        selectByMouse: true
                        persistentSelection: true
                    }
                }
            }

            // buttons
            RowLayout {
                id: bottom_bnts
                Layout.fillWidth: true
                Layout.margins: 5
                spacing: 10
                Item {
                    Layout.fillWidth: true
                }
                Button {
                    text: qsTr("Export")
                }
                Button {
                    text: qsTr("Open Directory")
                }
                Button {
                    text: qsTr("Close")
                    icon.source: "qrc:/icons/discard_editor.svg"
                    icon.color: "red"
                    onClicked: {
                        notebookWindow.close()
                    }
                }
            }
        }
    }

    function updateModel() {
        valueModel.clear()
        valueModel.append({ text: qsTr("Current Note") + " (" + notebookWindow.currentFile + ")" })
        valueModel.append({ text: qsTr("Current Buffer") + " (" + notebookWindow.currentFile + ")" })
        valueModel.append({ text: qsTr("Coconut Notebook") + " (" + notebookWindow.currentFolder + ")" })
        source_combo.currentIndex = 0
    }

    onCurrentFileChanged: updateModel()
    onCurrentFolderChanged: updateModel()
    Component.onCompleted: updateModel()

    onClosing: {
        notebookWindow.visible = false
    }
}
