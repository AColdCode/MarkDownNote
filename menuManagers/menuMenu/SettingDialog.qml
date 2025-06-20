import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

import "settingContents"

Window {
    id: settingWindow
    width: 450
    height: 300
    minimumHeight: 300
    minimumWidth: 400
    title: qsTr("Setting")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal
    color: "#f5f5f5"
    property bool isChanged: quickAccess_content.modified || general_content.modified


    ColumnLayout {
        width: parent.width
        height: parent.height

        RowLayout {
            width: parent.width
            spacing: -15
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 3
                Layout.margins: 10
                color: "white"

                ScrollView {
                    anchors.fill: parent

                    ListView {
                        anchors.fill: parent
                        id: selectSetting_list
                        model: ListModel {
                            ListElement { text: qsTr("Genral") }
                            ListElement { text: qsTr("Quick Access")}
                        }

                        delegate: Label {
                            width: parent.width
                            text: model.text

                            TapHandler {
                                onTapped: {
                                    selectSetting_list.currentIndex = index
                                }
                            }
                            HoverHandler {
                                id: listItem_hover
                            }

                            background: Rectangle {
                                color: listItem_hover.hovered ? "lightgrey" : "transparent"
                            }
                        }

                        highlight: Rectangle {
                            color: "grey"
                            width: ListView.view.width
                            height: ListView.view.height
                        }
                    }
                }
            }

            GeneralContent {
                id: general_content
                visible: selectSetting_list.currentIndex === 0
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 5
                Layout.margins: 10
            }

            QuickAccessContent {
                id: quickAccess_content
                visible: selectSetting_list.currentIndex === 1
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.horizontalStretchFactor: 5
                Layout.margins: 10
            }
        }

        RowLayout {
            width: parent.width
            Layout.bottomMargin: 10

            Item {
                width: 10
            }

            Button {
                id: reset_btn
                text: qsTr("Reset")
                icon.source: "qrc:/icons/reset.svg"
                enabled: isChanged

                onClicked: {
                    if(selectSetting_list.currentIndex === 0) {
                        general_content.reset()
                    }else if (selectSetting_list.currentIndex === 1){
                        quickAccess_content.reset()
                    }
                }
            }

            Item {
                id: name
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("OK")
                icon.source: "qrc:/icons/Ok.svg"

                onClicked: {
                    if(isChanged) {
                        apply_btn.clicked()
                    }
                    settingWindow.close()
                }
            }

            Button {
                id: apply_btn
                text: qsTr("Apply")
                icon.source: "qrc:/icons/Ok.svg"
                enabled: isChanged

                onClicked: {
                    if(selectSetting_list.currentIndex === 0) {
                        general_content.apply()
                    }else if (selectSetting_list.currentIndex === 1){
                        quickAccess_content.apply()
                    }
                }
            }

            Button {
                text: qsTr("Cancel")
                icon.source: "qrc:/icons/forbid.svg"

                onClicked: {
                    if(isChanged) {
                        reset_btn.clicked()
                    }

                    settingWindow.close()
                }
            }

            Item {
                width: 10
            }
        }
    }

    onClosing: {
        settingWindow.visible = false
    }
}
