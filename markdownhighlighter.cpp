// markdownhighlighter.cpp
#include "markdownhighlighter.h"

MarkdownHighlighter::MarkdownHighlighter(QTextDocument *parent)
: QSyntaxHighlighter(parent) {
    QTextCharFormat boldFormat;
    boldFormat.setFontWeight(QFont::Bold);
    boldFormat.setForeground(Qt::blue);
    rules.append({QRegularExpression(R"(\*\*(.*?)\*\*)"), boldFormat});

    QTextCharFormat italicFormat;
    italicFormat.setFontItalic(true);
    italicFormat.setForeground(Qt::darkGreen);
    rules.append({QRegularExpression(R"(\*(.*?)\*)"), italicFormat});
}

void MarkdownHighlighter::highlightBlock(const QString &text) {
    for (const auto &rule : rules) {
        QRegularExpressionMatchIterator matchIterator = rule.pattern.globalMatch(text);
        while (matchIterator.hasNext()) {
            QRegularExpressionMatch match = matchIterator.next();
            setFormat(match.capturedStart(), match.capturedLength(), rule.format);
        }
    }
}
