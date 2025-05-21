#pragma once

#include <QObject>

class ImportMenuCtrl : public QObject
{
    Q_OBJECT
public:
    explicit ImportMenuCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void selectFolder(QObject *textField);
    Q_INVOKABLE void selectFile();

signals:
};
