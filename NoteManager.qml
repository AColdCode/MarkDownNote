import QtQuick
import QtQuick.Controls

Rectangle {
    height: 40
    width: parent.width

    Row {
        anchors.fill: parent
        Button {
            text: "新建"
            onClicked: editor.text = ""
        }
        Button {
            text: "保存"
            onClicked: console.log("保存功能待实现")
        }
        Button {
            text: "打开"
            onClicked: console.log("打开功能待实现")
        }
    }
}
