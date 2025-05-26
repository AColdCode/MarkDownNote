import QtQuick
import QtWebEngine
import MarkDownNote 1.0

Rectangle {
    WebEngineView {
        id: webView
        anchors.fill: parent
        url: "https://www.qt.io"
    }

    property string markdownText: ""

    onMarkdownTextChanged: {
        webView.loadHtml(MarkDownCtrl.previewCtrl.convertToHtml(markdownText))
    }
}
