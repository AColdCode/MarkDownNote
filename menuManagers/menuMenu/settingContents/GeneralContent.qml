import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "#f5f5f5"
    border.color: "gray"
    property bool modified: false

    ColumnLayout {
        width: parent.width

        // Language
        RowLayout {
            Layout.fillWidth: true
            Layout.margins: 5

            Label {
                text: qsTr("Language")
                Layout.fillWidth: true
                Layout.minimumWidth: 90
                Layout.horizontalStretchFactor: 0
            }

            ComboBox {
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 1
                model: ListModel {
                    ListElement { text: qsTr("Default") }
                    ListElement { text: "American English(United States)" }
                    ListElement { text: "简体中文（中国）" }
                }
            }
        }

        CheckBox {
            text: qsTr("Minimize to system tray")
            checked: true
        }

        CheckBox {
            text: qsTr("Recover last session on start")
            checked: true
        }
    }

    function reset() {
        modified = false
    }

    function apply() {
        modified = true
    }
}
