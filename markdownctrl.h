#pragma once

#include <QObject>
#include <QQmlEngine>

class MarkDownCtrl : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_NAMED_ELEMENT(MarkDownCtrl)

public:
    explicit MarkDownCtrl(QObject *parent = nullptr);

    // 控制扩展区
    Q_INVOKABLE void showFullScreen();
    Q_INVOKABLE void exitFullScreen();
    Q_INVOKABLE void staysOnTop();
    Q_INVOKABLE void notStaysOnTop();

    // 传入QML组件
    QObject *mainWindow() const;
    void setMainWindow(QObject *newMainWindow);

signals:

    void mainWindowChanged();

private:
    QObject *m_mainWindow = nullptr;
    Q_PROPERTY(QObject *mainWindow READ mainWindow WRITE setMainWindow NOTIFY mainWindowChanged FINAL)
};
