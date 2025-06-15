import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import "dialogs"
import MarkDownNote 1.0

Rectangle {
    color: "#f5f5f5"
    border.color: "gray"
    property bool modified: false

    ColumnLayout {
        width: parent.width
        spacing: 10

        GroupBox {
            title: qsTr("Quick Note")
            Layout.fillWidth: true
            Layout.margins: 5

            ColumnLayout {
                spacing: 6
                width: parent.width

                // Scheme
                RowLayout {
                    Layout.fillWidth: true

                    Label {
                        text: qsTr("Scheme") + ":"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 90
                        Layout.horizontalStretchFactor: 0
                    }

                    ComboBox {
                        id: combo
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
                        model: MarkDownCtrl.quickNoteListModel
                        textRole: "name"

                        onCurrentIndexChanged: {
                            quickFolder.text = MarkDownCtrl.quickNoteListModel.getFolder(currentIndex)
                            noteName.text = MarkDownCtrl.quickNoteListModel.getNoteName(currentIndex)
                            modified = false
                        }
                    }

                    Button {
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
                        text: qsTr("New")

                        onClicked: newScheme.visible = true

                        NewQuickNoteScheme {
                            id: newScheme
                            visible: false
                        }
                    }

                    Button {
                        Layout.fillWidth: true
                        Layout.horizontalStretchFactor: 1
                        text: qsTr("Delete")
                        enabled: combo.count !== 0

                        onClicked: {
                            MarkDownCtrl.quickNoteListModel.removeAt(combo.currentIndex)
                        }
                    }
                }

                GroupBox {
                    visible: combo.count !== 0
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    ColumnLayout {
                        width: parent.width

                        // Folder
                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: qsTr("Folder")
                                Layout.fillWidth: true
                                Layout.minimumWidth: 90
                                Layout.horizontalStretchFactor: 0
                            }

                            TextField {
                                id: quickFolder
                                Layout.fillWidth: true
                                Layout.horizontalStretchFactor: 1

                                onTextChanged: {
                                    modified = true
                                }
                            }

                            Button {
                                Layout.fillWidth: true
                                Layout.horizontalStretchFactor: 0
                                text: qsTr("Browse")
                            }
                        }

                        // Note name
                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: qsTr("Note name")
                                Layout.fillWidth: true
                                Layout.minimumWidth: 90
                                Layout.horizontalStretchFactor: 0
                            }

                            TextField {
                                id: noteName
                                Layout.fillWidth: true
                                Layout.horizontalStretchFactor: 1

                                onTextChanged: {
                                    modified = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function reset(){
        quickFolder.text = MarkDownCtrl.quickNoteListModel.getFolder(combo.currentIndex)
        noteName.text = MarkDownCtrl.quickNoteListModel.getNoteName(combo.currentIndex)
        modified = false
    }

    function apply(){
        MarkDownCtrl.quickNoteListModel.updateQuickNote(combo.currentIndex, quickFolder.text, noteName.text)
        modified = false
    }
}
