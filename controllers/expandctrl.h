#pragma once

#include <QObject>

class ExpandCtrl : public QObject
{
    Q_OBJECT
public:
    explicit ExpandCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void showFullScreen();
    Q_INVOKABLE void exitFullScreen();
    Q_INVOKABLE void staysOnTop();
    Q_INVOKABLE void notStaysOnTop();
    Q_INVOKABLE void expendContent(bool selected);

    // GET/SET QML组件
    QObject *mainWindow() const;
    void setMainWindow(QObject *newMainWindow);

    QObject *sidebar() const;
    void setSidebar(QObject *newSidebar);

signals:

    void mainWindowChanged();

    void sidebarChanged();

private:
    QObject *m_mainWindow = nullptr;
    Q_PROPERTY(QObject *mainWindow READ mainWindow WRITE setMainWindow NOTIFY mainWindowChanged FINAL)

    QObject *m_sidebar = nullptr;
    Q_PROPERTY(QObject *sidebar READ sidebar WRITE setSidebar NOTIFY sidebarChanged FINAL)
};
