import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

import MarkDownNote 1.0

Window {
    id: newSchemeWindow
    width: 200
    height: 80
    minimumHeight: 80
    maximumHeight: 80
    minimumWidth: 200
    title: qsTr("Quick Note Scheme")
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    visible: false
    modality: Qt.ApplicationModal

    Column {
        spacing: 0
        anchors.margins: 5
        anchors.fill: parent

        Label {
            width: parent.width
            text: qsTr("Scheme name") + ":"
        }

        TextField {
            width: parent.width
            id: newSchemeName
        }
    }

    // 确定 / 取消按钮
    RowLayout {
        y: parent.height - height - 5
        x: parent.width - width - 5
        spacing: 10
        Button {
            text: qsTr("Ok")
            icon.source: "qrc:/icons/Ok.svg"
            onClicked: {
                MarkDownCtrl.addNewQuickNoteScheme(newSchemeName.text)
                newSchemeName.clear()
                newSchemeWindow.close()
            }
        }
        Button {
            text: qsTr("Cancel")
            icon.source: "qrc:/icons/forbid.svg"
            onClicked: {
                newSchemeWindow.close()
            }
        }
    }

    onClosing: {
        newSchemeWindow.visible = false
    }
}
