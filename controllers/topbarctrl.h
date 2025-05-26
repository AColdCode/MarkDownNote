#pragma once

#include <QObject>

class TopbarCtrl : public QObject
{
    Q_OBJECT
public:
    explicit TopbarCtrl(QObject *parent = nullptr);

    QObject *textArea() const;
    void setTextArea(QObject *newTextArea);
    Q_INVOKABLE void onBoldClicked();
    Q_INVOKABLE void menuItemSelected(int type);

signals:

    void textAreaChanged();

private:
    QObject *m_textArea = nullptr;
    Q_PROPERTY(QObject *textArea READ textArea WRITE setTextArea NOTIFY textAreaChanged FINAL)
    int oldtype = 0;
    int oldposition = 0;
};
