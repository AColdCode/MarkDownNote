import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import MarkDownNote 1.0

Rectangle {
    id: editorBackGround
    color: "#eeeeee"
    property alias text: editor.text
    property alias font: editor.font
    property alias textArea: editor
    property int currentLine: 0

    // 添加TextMetrics用于计算单行高度
    TextMetrics {
        id: textMetrics
        font: editor.font
        text: "X" // 任意字符用于测量高度
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        ScrollView {
            id: lineScrollView
            width: 40
            Layout.fillHeight: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            clip: true
            // Layout.topMargin: 5

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
                    // 使用textMetrics.height + 2作为行高（2像素的额外间距）
                    height: textMetrics.height
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
                text: model.content
                font.pixelSize: 14
                width: Math.max(implicitWidth, editorScrollView.width)
                height: contentHeight

                // 确保编辑器行高与行号区域一致
                topPadding: 0
                bottomPadding: 0
                leftPadding: 5
                rightPadding: 5

                property bool textDirty: false
                property bool firstLoad: true

                Timer {
                    id: autoSaveTimer
                    interval: 3000
                    repeat: false
                    onTriggered: {
                        if (editor.textDirty) {
                            MarkDownCtrl.editorModel.saveCurrentEditor(index, editor.text)
                            editor.textDirty = false
                        }
                    }
                }

                Shortcut {
                    sequence: StandardKey.Save
                    onActivated: {
                        editor.textDirty = !MarkDownCtrl.editorModel.saveCurrentEditor(index, editor.text)
                    }
                }

                onTextChanged: {
                    if (firstLoad) {
                        firstLoad = false
                    }else{
                        textDirty = true
                        autoSaveTimer.restart()
                    }
                }

                onTextDirtyChanged: {
                    MarkDownCtrl.editorModel.editorModified(index, textDirty)
                }

                onCursorPositionChanged: {
                    oldposition = newposition;
                    newposition = editor.cursorPosition;
                    Qt.callLater(() => {
                        const cursorPos = editor.cursorPosition;
                        const textBeforeCursor = editor.text.slice(0, cursorPos);
                        editorBackGround.currentLine = textBeforeCursor.split("\n").length - 1;
                    })
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
                    const start = fullText.lastIndexOf('\n', cursorPos - 1) + 1;
                    return start;
                }

                function getCurrentLineEnd() {
                    const cursorPos = editor.cursorPosition;
                    const fullText = editor.text;
                    let end = fullText.indexOf('\n', cursorPos);
                    if (end === -1) end = fullText.length;
                    return end;
                }

                background: Rectangle {
                    color: "white"
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
