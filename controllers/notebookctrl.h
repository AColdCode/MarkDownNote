#pragma once

#include <QObject>

class NoteBookCtrl : public QObject
{
    Q_OBJECT
public:
    explicit NoteBookCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void selectRoot(QObject *textField);
    Q_INVOKABLE void isLegalPath(const QString &rootPath, QObject *dialog);

signals:

private:
};
