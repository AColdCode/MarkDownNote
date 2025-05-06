import QtQuick
import QtQuick.Controls
import "../buttons"

SplitButton {
    id: expand_menu
    hoverText: qsTr("expand content")
    sequence: "Ctrl+E"
    icon.source: "qrc:/icons/expand.svg"

    popMenu: Menu {
        y: expand_menu.height
        SubMenuButton{
            property bool select: false
            label: qsTr("expand content")
            sequence: "Ctrl+E"
            spaces: "   "
            icon.source: "qrc:/icons/expand.svg"
            icon.color: select ? "red" : "black"

            onClicked: {
                select = !select
            }
        }

        SubMenuButton{
            property bool select: false
            label: qsTr("full screen")
            spaces: "           "
            sequence: "F11"
            icon.source: "qrc:/icons/fullscreen.svg"
            icon.color: select ? "red" : "black"

            onClicked: {
                select = !select
            }
        }

        SubMenuButton{
            property bool select: false
            label: qsTr("stay on top")
            sequence: "F10"
            spaces: "          "
            icon.source: "qrc:/icons/stay_on_top.svg"
            icon.color: select ? "red" : "black"

            onClicked: {
                select = !select
            }
        }

        SubMenuButton{
            label: qsTr("window")
        }
    }
}
