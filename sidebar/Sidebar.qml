
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: 40
    height: parent.height
    color: "#354259"
     property int selectedButtonIndex: -1

    Rectangle{

        width: 40
        height: 200
        color: "#354259"



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
                width: parent.width
                icon.source:model.icon
                icon.width: parent.width-10
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

}
