import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import MarkDownNote 1.0

Item {
    id: tabBarNames
    property int currentIndex: -1
    property string tabBarName: ""

    Flickable {
        id: tabFlick
        anchors.fill: parent
        clip: true
        contentWidth: tabRow.implicitWidth
        contentHeight: height
        flickableDirection: Flickable.HorizontalFlick


        RowLayout {
            id: tabRow
            anchors.fill: parent
            spacing: 1

            Repeater {
                id: tabName_repeater
                model:MarkDownCtrl.editorModel

                Item {
                    id: tabName
                    height: 26
                    Layout.maximumWidth: 100
                    Layout.minimumWidth: 100
                    property bool modified: false

                    RowLayout {
                        anchors.fill: parent
                        spacing: 0

                        Button {
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 1
                            text: model.fileName
                            icon.source: "qrc:/icons/buffer.svg"
                            icon.color: tabName.modified ? "red" : "black"
                            onClicked: {tabBarNames.currentIndex = index;tabBarNames.tabBarName=text;}
                            background: Rectangle {
                                color: "transparent"
                            }
                        }

                        // 关闭按钮
                        Button {
                            width: 20
                            height: 20
                            Layout.minimumHeight: 20
                            Layout.maximumHeight: 20
                            Layout.maximumWidth: 20
                            Layout.minimumWidth: 20
                            Layout.alignment : Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 0
                            Layout.rightMargin: 1
                            icon.source: "qrc:/icons/delete.svg"
                            icon.color: closeHover.hovered ? "white" : "grey"
                            onClicked: {
                                MarkDownCtrl.editorModel.closeEditor(index, tabBarNames.currentIndex >= index);

                            }
                            background: Rectangle {
                                color: closeHover.hovered ? "#ff6666" : "transparent"
                                radius: 10
                            }

                            HoverHandler {
                                id: closeHover
                            }
                        }
                    }

                    Rectangle {
                        anchors.fill: parent
                        z: -1
                        color: tabBarNames.currentIndex === index ? "white" : tabNameHover.hovered ? "lightgrey" :"#eee"
                        border.color: tabBarNames.currentIndex === index ? "green" : color
                    }
                    HoverHandler {
                        id: tabNameHover
                    }

                    ToolTip {
                        text: model.fileName
                        font.pointSize: 8
                        y:22
                        visible: tabNameHover.hovered
                        delay: 300
                        padding: 4
                    }
                }

                Component.onCompleted: {
                    MarkDownCtrl.editorModel.tabName_repeater = tabName_repeater
                }

                function editorModified(index, modified){
                    tabName_repeater.itemAt(index).modified = modified
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }

    onCurrentIndexChanged: {
        Qt.callLater(() => {
            tabBarNames.scrollToCurrentTab()
        })
    }

    function scrollToCurrentTab() {
        const item = tabRow.children[tabBarNames.currentIndex];
        if (!item)
            return;
        const left = item.x;
        const right = item.x + item.width;
        const viewLeft = tabFlick.contentX;
        const viewRight = viewLeft + tabFlick.width;

        if (left < viewLeft) {
            tabFlick.contentX = left; // 向左滚动
        } else if (right > viewRight) {
            tabFlick.contentX = right - tabFlick.width; // 向右滚动
        }
    }
}
