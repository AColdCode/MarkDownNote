import QtQuick 2.15
import QtQuick.Controls

Button {
    id: menuButton
    icon.height: 20
    icon.width: 20
    font.pixelSize: 14
    spacing: 1
    property alias sequence: menuShortcut.sequence

    property string hoverText: ""
    property bool showTooltip: false  // 控制 ToolTip 是否显示

    background: Rectangle {
        color: menuHover.hovered ? "white" : "grey"
        radius: 5
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
        text: menuButton.hoverText  + (menuShortcut.sequence === "" ? "" : "   " + menuShortcut.sequence)
        visible: menuButton.showTooltip
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
            menuButton.clicked()
        }
    }
}

