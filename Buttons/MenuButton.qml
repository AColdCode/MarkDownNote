import QtQuick 2.15
import QtQuick.Controls

Button {
    id: menuButton
    icon.height: 20
    icon.width: 20
    font.pixelSize: 14
    spacing: 1

    background: Rectangle {
        color: menuHover.ishovered ? "white" : "grey"
        radius: 5
    }

    HoverHandler{
        id: menuHover
    }
}
