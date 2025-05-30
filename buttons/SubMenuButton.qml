import QtQuick 2.15
import QtQuick.Controls

MenuItem {
    id: subMenu_item
    property alias sequence: menuItemShortcut.sequence
    property string label: ""
    property string spaces: ""
    property string iconSpaces: icon.source.toString() !== "" ? "" : "     "
    text: iconSpaces + label + spaces + sequence

    Shortcut {
        id: menuItemShortcut
        sequence: ""
        onActivated: {
            subMenu_item.triggered()
        }
    }
}
