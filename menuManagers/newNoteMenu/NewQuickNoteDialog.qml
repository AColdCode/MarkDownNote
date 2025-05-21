import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

Window {
    id: quickNoteWindow
    width: showlist ? 200 : 500
    height: showlist ? quicknote_model.count * 32 + 50 : 100
    // minimumHeight: 50
    minimumWidth: 200
    title: showlist ? qsTr("New Quick Note") : qsTr("Information")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal
    property bool showlist: quicknote_model.count !== 0

    ListModel{
       id: quicknote_model
    }

    ListView {
        id: quick_list
        anchors.fill: parent
        spacing: 1
        visible: showlist
        model: quicknote_model
        currentIndex: 0
        clip: true
        orientation: ListView.Vertical
        property bool isfooter: false

        delegate: Rectangle {
            width: parent.width
            height: 31
            color: delegat_hover.hovered ? "lightgrey" : "transparent"
            RowLayout {
                width: parent.width
                height: parent.height

                Rectangle {
                    width: 25
                    height: 25
                    Layout.leftMargin: 5
                    border.color: "green"
                    color: "transparent"
                    border.width: 1
                    radius: 3

                    Label {
                        anchors.fill: parent
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: String.fromCharCode(97 + index)
                        font.pixelSize: 25
                        color: "green"
                    }
                }

                Label {
                    text: model.name
                }

                Item {
                    Layout.fillWidth: true
                }
            }

            TapHandler {
                onTapped: {
                    quick_list.currentIndex = index
                    quick_list.isfooter = false
                }
            }

            HoverHandler {
                id: delegat_hover
            }
        }


        highlight: Rectangle {
            color: quick_list.isfooter ? "transparent" : "lightgrey"
        }

        footer: Rectangle {
            width: parent.width
            height: 31
            color: footer_hover.hovered | quick_list.isfooter ? "lightgrey" : "transparent"
            RowLayout {
                width: parent.width
                height: parent.height

                Rectangle {
                    width: 25
                    height: 25
                    Layout.leftMargin: 5
                    border.color: "green"
                    color: "transparent"
                    border.width: 1
                    radius: 3

                    Label {
                        anchors.fill: parent
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "z"
                        font.pixelSize: 25
                        color: "green"
                    }
                }

                Label {
                    text: qsTr("Cancel")
                }

                Item {
                    Layout.fillWidth: true
                }
            }

            TapHandler {
                onTapped: {
                    quick_list.isfooter = true
                    quickNoteWindow.close()
                }
            }

            HoverHandler {
                id: footer_hover
            }
        }
    }
    
    RowLayout {
        visible: !showlist
        anchors.fill: parent
        
        Image {
            Layout.leftMargin: 5
            sourceSize.height: 50
            sourceSize.width: 50
            source: "qrc:/icons/warn.svg"
        }

        Label {
            text: qsTr("Please set up note schemes in the Settings dialog first.")
        }
    }

    Button {
        visible: !showlist
        x: parent.width - width - 5
        y: parent.height - height - 5
        text: qsTr("OK")
        icon.source: "qrc:/icons/Ok.svg"

        onClicked: {
            quickNoteWindow.close()
        }
    }

    onClosing: {
        quickNoteWindow.visible = false
    }
}
