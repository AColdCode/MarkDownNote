import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    width: 400
    height: parent.height
    property alias text: editor.text

    TextArea {
        id: editor
        anchors.fill: parent
        wrapMode: TextEdit.Wrap
        text: "##Hello Markdown"
        onTextChanged: preview.markdownText = text
    }
}
