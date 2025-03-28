// markdownconverter.cpp
#include "markdownconverter.h"
#include <QRegularExpression>

MarkdownConverter::MarkdownConverter(QObject *parent) : QObject(parent) {}

QString MarkdownConverter::convertToHtml(const QString &markdown)
{
    QString html = markdown;
    html.replace(QRegularExpression(R"(\*\*(.*?)\*\*)"), R"(<b>\1</b>)"); // **加粗**
    html.replace(QRegularExpression(R"(\*(.*?)\*)"), R"(<i>\1</i>)");     // *斜体*
    return "<html><body>" + html + "</body></html>";
}
