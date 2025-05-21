import QtQuick 2.15
import QtQuick.Controls

import "../../buttons"

import MarkDownNote 1.0

SubMenuButton {
    id: helpButton
    label: qsTr("Help")
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
            label: qsTr("Feedback and Discussion")
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
        }
        MenuSeparator {
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
        SubMenuButton {
            label: qsTr("Contributor")
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

            onTriggered: {
                Qt.openUrlExternally("https://github.com/AColdCode/MarkDownNote/graphs/contributors")
            }
        }
        SubMenuButton {
            label: qsTr("About")
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

            onTriggered: {
                Qt.openUrlExternally("https://github.com/AColdCode/MarkDownNote")
            }
        }
        SubMenuButton {
            label: qsTr("About Qt")
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

            onTriggered: {
                MarkDownCtrl.menuCtrl.openAboutQt()
            }
        }
    }
}
