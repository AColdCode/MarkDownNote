import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    height: 28
    width: parent.width
    color: "grey"

    Row {
        id: menuLayout
        anchors.fill: parent
        height: parent.height
        width: parent.width
        spacing: 5

        MenuButton {
            text: qsTr("notebook")
            onClicked: console.log("功能待实现")
            icon.source: "qrc:/icons/navigation_dock.svg"
            background: Rectangle {
                color: menuHover1.ishovered ?"white": "grey"
                radius: 5
            }

            HoverHandler{
                id: menuHover1
            }
        }

        MenuButton {
            text: qsTr("new notes")
            onClicked: console.log("功能待实现")
            icon.source: "qrc:/icons/new_note.svg"
            background: Rectangle {
                color: menuHover2.ishovered ?"white": "grey"
                radius: 5
            }

            HoverHandler{
                id: menuHover2
            }
        }

        MenuButton {
            icon.source: "qrc:/icons/import_menu.svg"
            background: Rectangle {
                color: menuHover3.ishovered ?"white": "grey"
                radius: 5
            }

            HoverHandler{
                id: menuHover3
            }
        }

        MenuButton {
            icon.source: "qrc:/icons/export_menu.svg"
            background: Rectangle {
                color: menuHover4.ishovered ?"white": "grey"
                radius: 5
            }

            HoverHandler{
                id: menuHover4
            }
        }

        MenuButton {
            icon.source: "qrc:/icons/expand.svg"
            background: Rectangle {
                color: menuHover5.ishovered ?"white": "grey"
                radius: 5
            }

            HoverHandler{
                id: menuHover5
            }
        }
    }
}
