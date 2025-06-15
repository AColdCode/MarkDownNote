import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "../buttons"
import "noteBookMenu"

import MarkDownNote 1.0

MenuButton {
    id: noteBook_menu
    text: qsTr("Notebook")
    hoverText: qsTr("Notebook")
    onClicked: popMenu.open()
    icon.source: "qrc:/icons/navigation_dock.svg"

    Menu{
        id: popMenu
        y: parent.y + parent.height

        MenuItem{
            id: newNotebookMenu
            text: qsTr("New Notebook")
            onClicked: noteBook_new.visible = true
            NewNotebookDialog{
                id: noteBook_new
                visible: false
            }
            Component.onCompleted: {
                MarkDownCtrl.noteBookCtrl.newNotebookMenu = newNotebookMenu
            }
        }
        MenuItem{
            text: qsTr("New Notebook from a Folder")
            onClicked: newNotebook_Folder.visible = true
            NewNotebookFromFolderDialog{
                id: newNotebook_Folder
                visible: false
            }
        }

        MenuSeparator {}

        MenuItem {
            text: qsTr("Open other Notebooks")
            onClicked: openNotebooks_other.visible = true
            OpenOtherNotebooksDialog {
                id: openNotebooks_other
                visible: false
            }
        }

        MenuSeparator {}

        MenuItem {
            id: managementNotebook_
            Layout.fillWidth: true
            text: qsTr("Management Notebook")
            onClicked: managementNotebook.visible = true
            ManagementNotebookDialog {
                id: managementNotebook
                visible: false
            }

            Component.onCompleted: {
                MarkDownCtrl.noteBookCtrl.managementNotebook = managementNotebook_
            }
        }
    }

    Component.onCompleted: {
        MarkDownCtrl.noteBookCtrl.noteBookMenu = popMenu
    }
}
