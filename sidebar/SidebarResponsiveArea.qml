import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MarkDownNote
import "sidebarToggle"

Rectangle {
    id: fileTreeView
    width: 200
    height: Math.max(implicitHeight, parent.height)
    color: "#efeded"
    property int  currentIndex: 0

    ColumnLayout {
        anchors.fill: parent
        SnippetPage{
            id:snippetPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: currentIndex===3
        }

        SearchPage{
            id:searchPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: currentIndex===2
        }

        HistoryPage{
            id:historyPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: currentIndex===1
        }

        NavigationPage{
            id:navigationPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: currentIndex===0
        }

    }
    Component.onCompleted: {
        MarkDownCtrl.sidebarCtrl.fileTreeView=fileTreeView;
    }
}

