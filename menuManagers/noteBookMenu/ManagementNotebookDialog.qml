import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

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

    property bool modified: false


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
                ListView {
                    anchors.fill: parent
                    id: notebooks_list
                    model: MarkDownCtrl.noteBookmodel
                    currentIndex: 0

                    delegate: Rectangle {
                        height: 25
                        width: notebooks_list.width
                        color: notebooks_list.currentIndex === index ? "grey" : "white"
                        property string name: model.name
                        property string rootPath: model.rootPath
                        property string decs: model.description

                        Label {
                            anchors.fill: parent
                            anchors.centerIn: parent
                            anchors.margins: 5
                            text: name
                        }

                        TapHandler {
                            onTapped: {
                                if (modified){
                                    unsavedDialog.open()
                                }else {
                                    notebooks_list.currentIndex = index
                                }
                            }
                        }
                    }

                    onCurrentItemChanged: {
                        if(currentIndex === -1)
                        {
                            name_field.clear()
                            decs_field.clear()
                            pathField.clear()
                            closeAndDelete.enabled = false
                        }else
                        {
                            if(currentItem){
                                name_field.text = currentItem.name
                                decs_field.text = currentItem.decs
                                pathField.text = currentItem.rootPath
                                closeAndDelete.enabled = true
                            }
                        }

                        Qt.callLater(() => {
                            modified = false
                        })
                    }
                }
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
                                    id: name_field
                                    Layout.fillWidth: true
                                    placeholderText: qsTr("Name of notebook")
                                    placeholderTextColor: "grey"
                                    Layout.horizontalStretchFactor: 1

                                    onTextChanged: modified = true
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
                                    id: decs_field
                                    Layout.fillWidth: true
                                    placeholderTextColor: "grey"
                                    placeholderText: qsTr("Description of notebook")
                                    Layout.horizontalStretchFactor: 1

                                    onTextChanged: modified = true
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
                                    readOnly: true
                                    placeholderTextColor: "grey"
                                    placeholderText: qsTr("Path of notebook root folder")
                                    Layout.horizontalStretchFactor: 1
                                }
                            }
                        }
                    }
                }

                // 关闭/删除按钮
                RowLayout {
                    id: closeAndDelete
                    y: parent.height - height - 5
                    x: parent.width - width - 5
                    spacing: 10
                    Button {
                        text: qsTr("Close Notebook")
                        onClicked: {
                            if(modified){
                                unsavedDialog.open()
                            }else{
                                closeNotebookDialog.open()
                            }
                        }
                    }
                    Button {
                        text: qsTr("Delete")
                        onClicked: {
                            if(modified){
                                unsavedDialog.open()
                            }else{
                                deleteDialog.open()
                            }
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
            border.color: "red"
            visible: hint_area.text !== ""

            TextArea {
                id: hint_area
                anchors.fill: parent
                wrapMode: TextArea.Wrap
                readOnly: true
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

                onClicked: {
                    name_field.text = notebooks_list.currentItem.name
                    decs_field.text = notebooks_list.currentItem.decs
                    pathField.text = notebooks_list.currentItem.rootPath

                    Qt.callLater(() => {
                        modified = false
                    })
                }
            }

            Item {
                id: name
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("OK")
                icon.source: "qrc:/icons/Ok.svg"

                onClicked: {
                    if(modified){
                        if(name_field.text === ""){
                            hint_area.text = qsTr("Please specify a name for the notebook.")
                        }else{
                            hint_area.text = ""
                            modified = !MarkDownCtrl.noteBookmodel.updateNotebook(notebooks_list.currentIndex ,name_field.text, decs_field.text)
                        }
                    }
                    if(!modified){
                        notebookWindow.close()
                    }
                }
            }

            Button {
                text: qsTr("Apply")
                enabled: modified
                icon.source: "qrc:/icons/Ok.svg"

                onClicked: {
                    if(name_field.text === ""){
                        hint_area.text = qsTr("Please specify a name for the notebook.")
                    }else{
                        hint_area.text = ""
                        modified = !MarkDownCtrl.noteBookmodel.updateNotebook(notebooks_list.currentIndex ,name_field.text, decs_field.text)
                    }
                }
            }

            Button {
                text: qsTr("Cancel")
                icon.source: "qrc:/icons/forbid.svg"

                onClicked: notebookWindow.close()
            }
        }
    }

    MessageDialog {
        id: unsavedDialog
        title: qsTr("Warning")
        text: qsTr("There are unsaved changes to current notebook.")
        buttons: MessageDialog.Ok
    }

    MessageDialog {
        id: closeNotebookDialog
        title: qsTr("Question")
        text: qsTr("Close notebook (" + name_field.text + ")?\n\nThe notebook could be opened by MarkDownNote again via \"Open Other Notebooks\" operation.")
        buttons: MessageDialog.Ok | MessageDialog.Cancel

        onButtonClicked: function (button, role) {
             switch (button) {
             case MessageDialog.Ok:
                 if(MarkDownCtrl.noteBookmodel.removeRow(notebooks_list.currentIndex)){
                     notebooks_list.currentIndex = MarkDownCtrl.noteBookmodel.rowCount - 1
                 }

                 if(deleteDialog.clickOk){
                    MarkDownCtrl.noteBookmodel.openFolder(pathField.text)
                    deleteDialog.clickOk = false
                 }
                 break;
             }
         }
    }

    MessageDialog {
        id: deleteDialog
        title: qsTr("Warning")
        text: qsTr("Please close the notebook in VNote first and delete the notebook root folder files manually.\n\nPress \"Ok\" to close the notebook and open the location of the notebook root folder.")
        buttons: MessageDialog.Ok | MessageDialog.Cancel
        property bool clickOk: false

        onButtonClicked: function (button, role) {
             switch (button) {
             case MessageDialog.Ok:
                 deleteDialog.clickOk = true
                 closeNotebookDialog.open()
                 break;
             }
         }
    }


    onClosing: {
        notebookWindow.visible = false
    }
}
