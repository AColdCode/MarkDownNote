import QtQuick
import QtQuick.Controls

import "../buttons"
import "./menuMenu"

MenuButton {
    hoverText: qsTr("Menu")
    icon.source: "qrc:/icons/menu.svg"
    onClicked: popMenu.open()

    Menu{
        id: popMenu
        y: parent.y + parent.height
        width: 300

        SubMenuButton{
            label: qsTr("Settings")
            spaces: "                   "
            sequence: "Ctrl+Alt+P"
        }

        MenuSeparator {}

        SubMenuButton{
            label: qsTr("Edit the user profile")
        }
        SubMenuButton{
            label: qsTr("Open the user profile")
        }
        SubMenuButton{
            label: qsTr("Open the Default Configuration folder")
        }
        SubMenuButton{
            label: qsTr("New Notebook from a Folder")
        }

        MenuSeparator {}

        SubMenuButton{
            label: qsTr("Edit the MarkDown user style")
        }

        MenuSeparator {}

        SubMenuButton{
            label: qsTr("Reset the layout of the main window")
        }

        MenuSeparator {}

        SubMenuButton{
            label: qsTr("View log")
        }

        MenuSeparator {}

        SubMenuButton{
            label: qsTr("Shortcut key help")
        }
        SubMenuButton{
            label: qsTr("Markdown guide")
        }
        HelpMenuButton{
            id: helpButton
        }

        MenuSeparator {}

        SubMenuButton{
            label: qsTr("Restart")
        }
        SubMenuButton{
            label: qsTr("Quit")
            spaces: "                          "
            sequence: "Ctrl+Q"
        }
    }
}
