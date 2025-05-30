import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MarkDownNote

Rectangle {
    id: sidebar
    width: 40
    height: parent.height
    color: "#354259"
    property int selectedButtonIndex: 0
    property var buttonVisibility: ({
            "Notebook": true,
            "History": true,
            "Search": true,
            "Snippet": true
        })

    Rectangle{
        width: 40
        height: 200
        color: "#354259"

        ColumnLayout {
            width: parent.width
            spacing: 5

            Repeater {
                model: ListModel {
                    ListElement { icon: "qrc:/icons/notebook_menu.svg"; label: "Notebook" }
                    ListElement { icon: "qrc:/icons/history_dock.svg";  label: "History" }
                    ListElement { icon: "qrc:/icons/search_dock.svg";   label: "Search" }
                    ListElement { icon: "qrc:/icons/snippet_dock.svg";  label: "Snippet" }
                }
                delegate: Button {
                    id: buttonDelegate
                    Layout.fillWidth: true
                    icon.source:model.icon
                    icon.height: 20
                    icon.width: 20
                    icon.color: "#f6f3f3"
                    visible: sidebar.buttonVisibility[model.label]

                    background: Rectangle {
                        implicitHeight: 40
                        color: parent.hovered ? "#e0e0e0" : (index === sidebar.selectedButtonIndex ?  "#1c2128" : "#354259")
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
                        sidebar.selectedButtonIndex = index
                        MarkDownCtrl.sidebarCtrl.openlabel(index)
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        MarkDownCtrl.sidebarCtrl.sidebar=sidebar
    }
}
