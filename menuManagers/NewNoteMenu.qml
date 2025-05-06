import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../buttons"

SplitButton{
    id: newNote_menu
    text: qsTr("new notes")
    sequence: "Ctrl+Alt+N"
    hoverText: qsTr("new notes")
    onClicked: console.log("功能待实现")
    icon.source: "qrc:/icons/new_note.svg"

    popMenu: Menu{
        y: parent.y + parent.height
        width: 250
        SubMenuButton{
            label: qsTr("New Notes")
            spaces: "              "
            sequence: "Ctrl+Alt+N"
            icon.source: "qrc:/icons/new_note.svg"
        }
        SubMenuButton{
            label: qsTr("New Quick Notes")
            spaces: "    "
            sequence: "Ctrl+Alt+Q"
            icon.source: "qrc:/icons/new_note.svg"
        }
        SubMenuButton{
            label: qsTr("New Folder")
            spaces: "             "
            sequence: "Ctrl+Alt+S"
            icon.source: "qrc:/icons/new_folder.svg"
        }

        MenuSeparator {}

        SubMenuButton{
            text: "     " + qsTr("Open File")
        }
    }
}
