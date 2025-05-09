import QtQuick 2.15
import QtQuick.Controls

import "../../buttons"

SubMenuButton {
    id: helpButton
    label: qsTr("window")
    icon.source: "qrc:/icons/decrease_outline_level.svg"
    icon.color: "grey"
    property bool mouseOverButton: false
    property int mouseOverMenu: 0

    HoverHandler {
        id: buttonHover
        onHoveredChanged: {
            helpButton.mouseOverButton = hovered
            if (hovered) {
                openMenuTimer.start()
                closeMenuTimer.stop()
            } else {
                closeMenuTimer.start()
            }
        }
    }

    // 延迟打开菜单
    Timer {
        id: openMenuTimer
        interval: 400  // 400 毫秒后打开
        running: false
        repeat: false
        onTriggered: {
            if (helpButton.mouseOverButton && !helpMenu.visible) {
                helpMenu.open()
            }
        }
    }

    // 延迟关闭菜单
    Timer {
        id: closeMenuTimer
        interval: 600  // 600 毫秒后关闭
        running: false
        repeat: false
        onTriggered: {
            if (!helpButton.mouseOverButton && (helpButton.mouseOverMenu === 0) && helpMenu.visible) {
                helpMenu.close()
            }
        }
    }

    Menu {
        id: helpMenu
        x: -width

        SubMenuButton {
            label: qsTr("Navigation")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1
                        closeMenuTimer.stop()
                    }
                }
            }

            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }

        SubMenuButton {
            label: qsTr("History")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1 << 1
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1 << 1
                        closeMenuTimer.stop()
                    }
                }
            }
            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }
        SubMenuButton {
            label: qsTr("Tags")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1 << 2
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1 << 2
                        closeMenuTimer.stop()
                    }
                }
            }
            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }
        SubMenuButton {
            label: qsTr("Search")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1 << 3
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1 << 3
                        closeMenuTimer.stop()
                    }
                }
            }
            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }
        SubMenuButton {
            label: qsTr("Snippets")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1 << 4
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1 << 4
                        closeMenuTimer.stop()
                    }
                }
            }
            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }
        SubMenuButton {
            label: qsTr("Outline")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1 << 5
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1 << 5
                        closeMenuTimer.stop()
                    }
                }
            }
            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }
        SubMenuButton {
            label: qsTr("Open Windows")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1 << 6
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1 << 6
                        closeMenuTimer.stop()
                    }
                }
            }
            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }
        SubMenuButton {
            label: qsTr("Console")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1 << 7
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1 << 7
                        closeMenuTimer.stop()
                    }
                }
            }
            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }
        SubMenuButton {
            label: qsTr("Location List")
            icon.color: "black"
            property bool selected: false
            HoverHandler {
                onHoveredChanged: {
                    if (!hovered) {
                        helpButton.mouseOverMenu &= ~1 << 8
                        closeMenuTimer.start()
                    } else {
                        helpButton.mouseOverMenu |= 1 << 8
                        closeMenuTimer.stop()
                    }
                }
            }
            onClicked: {
                if(selected){
                    selected = false
                    icon.source = ""
                }else{
                    selected = true
                    icon.source = "qrc:/icons/drop_down.svg"
                }
            }
        }
    }
}
