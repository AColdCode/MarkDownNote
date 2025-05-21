import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#354259"
    property int selectedButtonIndex: -1

    ColumnLayout {
        width: parent.width
        spacing: 5

        Repeater {
            model: ListModel {
                ListElement { icon: "qrc:/icons/notebook_menu.svg"; label: "Notebook Menu" }
                ListElement { icon: "qrc:/icons/tag_dock.svg";     label: "Tag Dock" }
                ListElement { icon: "qrc:/icons/search_dock.svg";   label: "Search Dock" }
                ListElement { icon: "qrc:/icons/snippet_dock.svg";  label: "Snippet Dock" }
            }

            delegate: Button {
                id: buttonDelegate
                Layout.fillWidth: true
                icon.source:model.icon
                icon.height: 20
                icon.width: 20
                icon.color: "#f6f3f3"

                background: Rectangle {
                    implicitHeight: 40
                    color: parent.hovered ? "#e0e0e0" : (index === root.selectedButtonIndex ?  "#1c2128" : "#354259")
                }

                ToolTip {
                    parent: buttonDelegate
                    text: model.label
                    font.pointSize: 8
                    y:22
                    visible: buttonDelegate.hovered
                    delay: 300
                    padding: 4
                }

                onClicked: {
                    root.selectedButtonIndex = index
                    console.log(model.label)
                }
            }
        }
    }
}
