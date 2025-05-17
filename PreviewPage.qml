import QtQuick
import QtWebEngine

Rectangle {
    WebEngineView {
        id: webView
        anchors.fill: parent
        url: "https://www.qt.io"
    }

    property string markdownText: ""

    onMarkdownTextChanged: {
        if (markdownText.length > 0) {
            webView.loadHtml(markdownConverter.convertToHtml(markdownText))
        }
    }
}
