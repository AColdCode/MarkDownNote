import QtQuick

import "../buttons"
import "exportMenu"

MenuButton {
    hoverText: qsTr("Export")
    sequence: "Ctrl+T"
    icon.source: "qrc:/icons/export_menu.svg"
    onClicked: exportDialog.visible = true
    ExportDialog {
        id: exportDialog
        visible: false
    }
}
