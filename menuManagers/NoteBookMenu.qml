import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../buttons"

MenuButton {
    text: qsTr("notebook")
    hoverText: qsTr("notebook")
    onClicked: popMenu.open()
    icon.source: "qrc:/icons/navigation_dock.svg"

    Menu{
        id: popMenu
        y: parent.y + parent.height

        MenuItem{
            text: qsTr("New Notebook")
        }
        MenuItem{
            text: qsTr("New Notebook from a Folder")
        }

        MenuSeparator {}

        MenuItem{
            text: qsTr("Open other Notebooks")
        }

        MenuSeparator {}

        MenuItem{
            Layout.fillWidth: true
            text: qsTr("Management Notebook")
        }
    }
}
