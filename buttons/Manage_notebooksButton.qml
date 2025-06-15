import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import MarkDownNote 1.0

Button {
    id: manage_notebooksbutton
    icon.source: "qrc:/icons/manage_notebooks.svg"
    icon.width: 15

    onClicked: {
        MarkDownCtrl.noteBookCtrl.openManageDialog()
    }

    ToolTip {
        parent: manage_notebooksbutton
        text: "管理笔记本"
        font.pointSize: 8
        y: 22
        visible: manage_notebooksbutton.hovered
        delay: 300
        padding: 4
    }

    background: Rectangle {
        color: parent.hovered ? "#e0e0e0" : "transparent"
    }
}
