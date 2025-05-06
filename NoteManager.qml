import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "buttons"
import "menuManagers"

Rectangle {
    height: 28
    width: parent.width
    color: "grey"

    RowLayout {
        id: menuLayout
        anchors.fill: parent
        height: parent.height
        width: parent.width
        spacing: 5

        NoteBookMenu{
            id: noteBook_menu
        }

        NewNoteMenu{
            id: newNote_menu
        }

        ImportMenu{
            id: import_menu
        }

        ExportMenu{
            id: export_menu
        }

        Item {
            Layout.fillWidth: true
        }

        ExpandMenu{
            id: expand_menu
        }

        MenuMenu{
            id: menu_menu
        }
    }
}
