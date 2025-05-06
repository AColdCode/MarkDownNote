import QtQuick
import QtQuick.Controls

import "../buttons"

MenuButton {
    hoverText: qsTr("menu")
    icon.source: "qrc:/icons/menu.svg"
    onClicked: popMenu.open()

    Menu{
        id: popMenu
        y: parent.y + parent.height

        SubMenuButton{
            text: qsTr("Settings")
        }
        SubMenuButton{
            text: qsTr("New Notebook from a Folder")
        }

        MenuSeparator {}
    }
}
