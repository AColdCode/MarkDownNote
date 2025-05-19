#pragma once

#include <QObject>

class PreviewCtrl : public QObject
{
    Q_OBJECT
public:
    explicit PreviewCtrl(QObject *parent = nullptr);

    Q_INVOKABLE QString convertToHtml(const QString &markdown);
signals:
};
