// markdownconverter.h
#ifndef MARKDOWNCONVERTER_H
#define MARKDOWNCONVERTER_H

#include <QObject>
#include <QQmlEngine>

class MarkdownConverter : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_NAMED_ELEMENT(MarkdownConverter)

public:
    explicit MarkdownConverter(QObject *parent = nullptr);
    Q_INVOKABLE QString convertToHtml(const QString &markdown);
};

#endif // MARKDOWNCONVERTER_H
