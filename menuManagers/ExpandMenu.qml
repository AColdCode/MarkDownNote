import QtQuick
import QtQuick.Controls
import "../buttons"
import "./expandMenu"

import MarkDownNote 1.0

SplitButton {
    id: expand_menu
    hoverText: qsTr("Expand Content Area")
    sequence: "Ctrl+E"
    icon.source: "qrc:/icons/expand.svg"
    property bool selected: false
    icon.color: selected ? "red" : "black"

    popMenu: Menu {
        y: expand_menu.height
        SubMenuButton{
            property bool select: false
            label: qsTr("expand content")
            sequence: "Ctrl+E"
            spaces: "   "
            icon.source: "qrc:/icons/expand.svg"
            icon.color: expand_menu.selected ? "red" : "black"

            onTriggered: {
                expand_menu.selected = !expand_menu.selected
            }
        }

        SubMenuButton{
            property bool select: false
            label: qsTr("full screen")
            spaces: "           "
            sequence: "F11"
            icon.source: "qrc:/icons/fullscreen.svg"
            icon.color: select ? "red" : "black"

            onTriggered: {
                select = !select
                if(select){
                    MarkDownCtrl.expandCtrl.showFullScreen()
                }else{
                    MarkDownCtrl.expandCtrl.exitFullScreen()
                }
            }
        }

        SubMenuButton{
            property bool select: false
            label: qsTr("stay on top")
            sequence: "F10"
            spaces: "          "
            icon.source: "qrc:/icons/stay_on_top.svg"
            icon.color: select ? "red" : "black"

            onTriggered: {
                select = !select
                if(select) {
                    MarkDownCtrl.expandCtrl.staysOnTop()
                }else{
                    MarkDownCtrl.expandCtrl.notStaysOnTop()
                }
            }
        }

        WindowMenuButton {
            id: windowMenu_btn
        }
    }

    onClicked: {
        selected = !selected
    }

    onSelectedChanged: {
        MarkDownCtrl.expandCtrl.expandContent(selected)
    }
}
