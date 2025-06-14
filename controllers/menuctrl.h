#pragma once

#include <QObject>

class MenuCtrl : public QObject
{
    Q_OBJECT
public:
    explicit MenuCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void exitApp();
    Q_INVOKABLE void restartApp();
    Q_INVOKABLE void openAboutQt();

    // GET/SET QML组件
    QObject *mainWindow() const;
    void setMainWindow(QObject *newMainWindow);

signals:
    void mainWindowChanged();

private:
    QObject *m_mainWindow = nullptr;
    Q_PROPERTY(QObject *mainWindow READ mainWindow WRITE setMainWindow NOTIFY mainWindowChanged FINAL)
};
