import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

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
                fileDialog.open()
            }

            FileDialog {
                id: fileDialog
                title: qsTr("Select Files To Import")
                onAccepted: {
                    console.log("你选择的文件是:", fileDialog.currentFile)
                }
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
