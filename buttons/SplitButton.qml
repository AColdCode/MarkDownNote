// SplitButton.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
    id: splitButton
    signal clicked()
    property alias icon: mainButton.icon
    property alias sequence: menuShortcut.sequence

    property string text: ""
    property string hoverText: ""
    property bool showTooltip: false  // 控制 ToolTip 是否显示
    property real radius: 5
    property Menu popMenu: Menu{}
    width: mainButton.width + arrowButton.width
    height: mainButton.height


    RowLayout {
        spacing: -10

        Button {
            id: mainButton
            text: splitButton.text + "  "
            icon.height: 20
            icon.width: 20
            font.pixelSize: 14
            onClicked: splitButton.clicked()
            background: Rectangle {
                color: menuHover.hovered ? "white" : "grey"
                radius: splitButton.radius
            }
        }

        Button {
            id: arrowButton
            icon.source: "qrc:/icons/drop_down.svg"
            font.pixelSize: 14
            icon.height: 20
            icon.width: 20
            icon.color: "black"
            onClicked: popMenu.open()
            background: Rectangle {
                color: menuHover.hovered ? "white" : "grey"
                radius: splitButton.radius
            }
        }
    }

    HoverHandler {
        id: menuHover
        onHoveredChanged: {
            if (hovered) {
                hoverTimer.restart(); // 鼠标进入时重启计时器
            } else {
                hoverTimer.stop();
                showTooltip = false; // 鼠标移开时隐藏
            }
        }
    }

    Timer {
        id: hoverTimer
        interval: 1000
        repeat: false
        onTriggered: showTooltip = true
    }

    // hint label
    ToolTip {
        text: splitButton.hoverText  + (menuShortcut.sequence === "" ? "" : "   " + menuShortcut.sequence)
        visible: splitButton.showTooltip
        x: parent.width / 2
        y: parent.height
        background: Rectangle
        {
            color: "green"
            radius: 5
        }
    }

    Shortcut {
        id: menuShortcut
        sequence: ""
        onActivated: {
            console.log("快捷键被按下")
            splitButton.clicked()
        }
    }
}
