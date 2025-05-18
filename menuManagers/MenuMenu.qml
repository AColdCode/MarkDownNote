import QtQuick
import QtQuick.Controls

import "../buttons"
import "./menuMenu"

import MarkDownNote 1.0

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
            
            onTriggered: setting_dialog.visible = true
            SettingDialog{
                id: setting_dialog
                visible: false
            }
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

            onTriggered: {
                MarkDownCtrl.restartApp()
            }
        }
        SubMenuButton{
            label: qsTr("Quit")
            spaces: "                          "
            sequence: "Ctrl+Q"

            onTriggered: {
                MarkDownCtrl.exitApp()
            }
        }
    }
}
