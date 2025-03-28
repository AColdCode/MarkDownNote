// markdownconverter.h
#ifndef MARKDOWNCONVERTER_H
#define MARKDOWNCONVERTER_H

#include <QObject>

class MarkdownConverter : public QObject
{
    Q_OBJECT
public:
    explicit MarkdownConverter(QObject *parent = nullptr);
    Q_INVOKABLE QString convertToHtml(const QString &markdown);
};

#endif // MARKDOWNCONVERTER_H
