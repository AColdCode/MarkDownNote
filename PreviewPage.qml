import QtQuick
import QtWebEngine

Rectangle {
    width: 800
    height: 600

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
