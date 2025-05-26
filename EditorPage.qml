import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import MarkDownNote 1.0

Rectangle {
    property alias text: editor.text
    property alias font: editor.font        

    ColumnLayout {
        anchors.fill: parent
        spacing: 1
        Rectangle {
            Layout.fillWidth: true
            height: 25
            Layout.fillHeight: true
            Layout.verticalStretchFactor: 0
            color: "#e0e0e0"
            RowLayout {
                anchors.fill: parent
                spacing: 5 // 可以调整间距

                // 中间空白区域
                Rectangle {

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                }

                // 第一个图标按钮
                Button {
                    Layout.fillHeight: true
                    background: Rectangle {
                        color: "transparent"
                    }
                    icon.source: "qrc:/icons/split_window_list.svg"
                    onClicked: console.log("Snippet Dock Clicked")
                }
                // 第二个图标按钮
                WorkspaceMenu{}
            }
        }

        Topbar {
            id:topbar
            Layout.fillWidth: true
            height: 25
            Layout.fillHeight: true
            Layout.verticalStretchFactor: 0
        }

        Rectangle {
            id: editorBackGround
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.verticalStretchFactor: 1
            color: "#eeeeee"
            property int currentLine: 0

            RowLayout {
                anchors.fill: parent
                spacing: 0

                ScrollView {
                    id: lineScrollView
                    width: 40
                    Layout.fillHeight: true
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                    clip: true
                    Layout.topMargin: 5

                    ListView {
                        id: lineNumberView
                        width: 40
                        spacing: 0
                        model: editor.lineCount
                        currentIndex: editorBackGround.currentLine
                        interactive: true
                        clip: true

                        delegate: Text {
                            text: index + 1
                            font.pixelSize: editor.font.pixelSize
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: lineNumberView.currentIndex === index ? "black" : "lightgrey"
                            height: editor.contentHeight / editor.lineCount
                            width: lineNumberView.width
                        }
                    }
                    background: Rectangle {
                        anchors.fill: parent
                        z: -1
                        color: "#fafafa"
                    }

                    ScrollBar.vertical.onPositionChanged: {
                        editorScrollView.ScrollBar.vertical.position = ScrollBar.vertical.position
                    }
                }

                // 编辑器区域
                ScrollView {
                    id: editorScrollView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded
                    ScrollBar.horizontal.policy: ScrollBar.AsNeeded

                    TextArea {
                        id: editor
                        wrapMode: TextEdit.NoWrap
                        selectByMouse: true
                        text: "## MarkDownNote"
                        font.pixelSize: 14
                        width: Math.max(implicitWidth, editorScrollView.width)
                        height: contentHeight

                        onCursorPositionChanged: {
                            oldposition = newposition;
                            newposition = editor.cursorPosition;
                            Qt.callLater(() => {
                                const cursorPos = editor.cursorPosition;
                                const textBeforeCursor = editor.text.slice(0, cursorPos);
                                editorBackGround.currentLine = textBeforeCursor.split("\n").length - 1;

                            })
                        }

                        Component.onCompleted: {
                            MarkDownCtrl.topbarCtrl.textArea = editor
                        }

                        onSelectedTextChanged: {
                            oldselection_End = selection_End;
                            oldselection_Start = selection_Start
                            selection_Start = editor.selectionStart;
                            selection_End = editor.selectionEnd;
                            oldstart = start;
                            start = getCurrentLineStart();
                        }





                        property int selection_Start: 0
                        property int selection_End: 0
                        property int oldselection_Start:0
                        property int oldselection_End: 0
                        property int oldstart: 0
                        property int start: 0
                        property int oldposition:0
                        property int newposition:0

                        function getCurrentLineStart() {
                            const cursorPos =oldposition
                            const fullText = editor.text;

                            // 找到光标前最近的换行符
                            const start = fullText.lastIndexOf('\n', cursorPos - 1) + 1;

                            return start;
                        }


                        function getCurrentLineEnd() {
                            const cursorPos = editor.cursorPosition;
                            const fullText = editor.text;
                            // 找到光标后最近的换行符
                            let end = fullText.indexOf('\n', cursorPos);
                            if (end === -1) end = fullText.length;

                            return end;
                        }
                    }

                    ScrollBar.vertical.onPositionChanged: {
                        Qt.callLater(() => {
                            lineScrollView.ScrollBar.vertical.position = ScrollBar.vertical.position;
                        })
                    }

                    TapHandler {
                        onTapped: {
                            editor.forceActiveFocus()
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        editor.forceActiveFocus()
    }
}
