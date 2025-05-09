import QtQuick
import QtQuick.Controls

import "../buttons"

MenuButton {
    hoverText: qsTr("Import")
    icon.source: "qrc:/icons/import_menu.svg"
    onClicked: popMenu.open()

    Menu {
        id: popMenu
        y: parent.y + parent.height

        MenuItem{
            text: qsTr("Import File")
        }
        MenuItem{
            text: qsTr("Import Folder")
        }
    }
}
