import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import MarkDownNote 1.0

import "../buttons"
import "newNoteMenu"

SplitButton{
    id: newNote_menu
    text: qsTr("New notes")
    sequence: "Ctrl+Alt+N"
    hoverText: qsTr("New notes")
    icon.source: "qrc:/icons/new_note.svg"

    onClicked: newnote.visible = true
    NewNoteDialog {
        id: newnote
        visible: false
    }

    popMenu: Menu{
        y: parent.y + parent.height
        width: 250
        SubMenuButton{
            label: qsTr("New Notes")
            spaces: "              "
            sequence: "Ctrl+Alt+N"
            icon.source: "qrc:/icons/new_note.svg"

            onClicked: newNote_menu.clicked()
        }
        SubMenuButton{
            label: qsTr("New Quick Notes")
            spaces: "    "
            sequence: "Ctrl+Alt+Q"
            icon.source: "qrc:/icons/new_note.svg"
            onClicked: newQuicknote.visible = true
            NewQuickNoteDialog {
                id: newQuicknote
                visible: false
            }
        }
        SubMenuButton{
            label: qsTr("New Folder")
            spaces: "             "
            sequence: "Ctrl+Alt+S"
            icon.source: "qrc:/icons/new_folder.svg"
            onClicked: newfolder.visible = true
            NewFolderDialog {
                id: newfolder
                visible: false
            }
        }

        MenuSeparator {}

        SubMenuButton{
            label: qsTr("Open File")
            onClicked: {
                MarkDownCtrl.newNotesCtrl.selectFile()
            }
        }
    }
}
