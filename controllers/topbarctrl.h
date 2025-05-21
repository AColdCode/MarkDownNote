#pragma once

#include <QObject>

class TopbarCtrl : public QObject
{
    Q_OBJECT
public:
    explicit TopbarCtrl(QObject *parent = nullptr);

    QObject *textArea() const;
    void setTextArea(QObject *newTextArea);

signals:

    void textAreaChanged();

private:
    QObject *m_textArea = nullptr;
    Q_PROPERTY(QObject *textArea READ textArea WRITE setTextArea NOTIFY textAreaChanged FINAL)
};
