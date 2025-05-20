import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import MarkDownNote 1.0

import "../buttons"
import "importMenu"

MenuButton {
    hoverText: qsTr("Import")
    icon.source: "qrc:/icons/import_menu.svg"
    onClicked: popMenu.open()

    Menu {
        id: popMenu
        y: parent.y + parent.height

        MenuItem{
            text: qsTr("Import File")
            onClicked: {
                MarkDownCtrl.importMenuCtrl.selectFile()
            }
        }
        MenuItem{
            text: qsTr("Import Folder")
            onClicked: importfloder.visible = true
            ImportFolderDialog {
                id: importfloder
                visible: false
            }
        }
    }
}
