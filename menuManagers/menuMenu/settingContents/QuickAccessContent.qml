import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import "dialogs"
import MarkDownNote 1.0

Rectangle {
    color: "#f5f5f5"
    border.color: "gray"

    property alias quickNote_model: quickNote_model_

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
                        model: ListModel {
                            id: quickNote_model_

                            onCountChanged: {
                                combo.currentIndex = count - 1
                            }
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
                        enabled: quickNote_model.count !== 0

                        onClicked: {
                            quickNote_model.remove(combo.currentIndex, 1)
                        }
                    }
                }

                GroupBox {
                    visible: quickNote_model.count !== 0
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
                                Layout.fillWidth: true
                                Layout.horizontalStretchFactor: 1
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
                                Layout.fillWidth: true
                                Layout.horizontalStretchFactor: 1
                            }
                        }
                    }
                }
            }
        }
    }

    function addQuickNoteScheme(name) {
        quickNote_model.append({text: name})
    }

    Component.onCompleted: {
        MarkDownCtrl.quickAccess = this
    }
}
