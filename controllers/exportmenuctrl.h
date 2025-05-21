#pragma once

#include <QObject>

class ExportMenuCtrl : public QObject
{
    Q_OBJECT
public:
    explicit ExportMenuCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void selectFolder(QObject *textField);

signals:
};
