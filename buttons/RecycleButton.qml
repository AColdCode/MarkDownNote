import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Button {
    id:recycleButton
    onClicked: recyclemenu.popup()
    icon.source: "qrc:/icons/recycle_bin.svg"
    icon.width:15
    background: Rectangle {
        color: parent.hovered ? "#e0e0e0": "transparent"

    }
    ToolTip {
        parent: recycleButton
        text: "回收站"
        font.pointSize: 8
        y:22
        visible: recycleButton.hovered
        delay: 300
        padding: 4
    }
    Menu{
        id:recyclemenu
        y: recycleButton.height
        MenuItem {
            text: qsTr("打开回收站")
            onTriggered: console.log("打开回收站 被选中")
        }
        MenuItem{
            text:qsTr("清空回收站")
            onTriggered: console.log("清空回收站 被选中")
        }



    }

}
