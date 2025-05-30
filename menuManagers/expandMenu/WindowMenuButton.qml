import QtQuick 2.15
import QtQuick.Controls

import "../../buttons"
import MarkDownNote

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
            id:notebookButton
            label: qsTr("Navigation")
            icon.color: "black"
            icon.source: selected?"qrc:/icons/Ok.svg":""
            property bool selected: true
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

                }else{
                    selected = true
                }
                 MarkDownCtrl.sidebarCtrl.showLabelChanged("Notebook")
            }
        }

        SubMenuButton {
            id:historyButton
            label: qsTr("History")
            icon.color: "black"
            icon.source: selected?"qrc:/icons/Ok.svg":""
            property bool selected: true
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
                }else{
                    selected = true
                }
                MarkDownCtrl.sidebarCtrl.showLabelChanged("History")
            }
        }
        SubMenuButton {
            id:searchButton
            label: qsTr("Search")
            icon.color: "black"
            icon.source: selected?"qrc:/icons/Ok.svg":""
            property bool selected: true
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
                }else{
                    selected = true
                }
                MarkDownCtrl.sidebarCtrl.showLabelChanged("Search")
            }
        }
        SubMenuButton {
            id:snippetButton
            label: qsTr("Snippets")
            icon.color: "black"
            icon.source: selected?"qrc:/icons/Ok.svg":""
            property bool selected: true
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
                }else{
                    selected = true
                }
                MarkDownCtrl.sidebarCtrl.showLabelChanged("Snippet")
            }
        }
        SubMenuButton {
            id:locationListButton
            label: qsTr("Location List")
            icon.color: "black"
            icon.source: selected?"qrc:/icons/Ok.svg":""
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
                }else{
                    selected = true
                }
                MarkDownCtrl.sidebarCtrl.openlocationlist()
            }
        }
    }
    Connections {
        target: MarkDownCtrl.sidebarCtrl

        function onLabelVisibilityChanged(label, visible) {
            if (label === "Notebook") {
                notebookButton.selected = visible;
            } else if (label === "History") {
                historyButton.selected = visible;
            }else if(label==="Search"){
                searchButton.selected=visible;
            }else if(label==="Snippet"){
                snippetButton.selected=visible;
            }
        }
        function onLocationlistVisibilityChanged(visible){
            locationListButton.selected=visible;
        }
    }
}
