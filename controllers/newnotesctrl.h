#pragma once

#include <QObject>

class NewNotesCtrl : public QObject
{
    Q_OBJECT
public:
    explicit NewNotesCtrl(QObject *parent = nullptr);

    Q_INVOKABLE QString selectFile();

signals:
};
