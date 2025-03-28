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
        spacing: 5
        MenuButton {
            text: qsTr("notebook")
            onClicked: console.log("功能待实现")
            icon.source: "qrc:/icons/navigation_dock.svg"
        }

        MenuButton {
            text: qsTr("new notes")
            onClicked: console.log("功能待实现")
            icon.source: "qrc:/icons/new_note.svg"
        }

        MenuButton {
            icon.source: "qrc:/icons/import_menu.svg"
        }

        MenuButton {
            icon.source: "qrc:/icons/export_menu.svg"
        }
    }
}
