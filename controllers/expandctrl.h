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
    Q_INVOKABLE void expandContent(bool selected);

    // GET/SET QML组件
    QObject *mainWindow() const;
    void setMainWindow(QObject *newMainWindow);

    QObject *rightContent() const;
    void setRightContent(QObject *newRightContent);

signals:

    void mainWindowChanged();

    void rightContentChanged();

private:
    QObject *m_mainWindow = nullptr;
    Q_PROPERTY(QObject *mainWindow READ mainWindow WRITE setMainWindow NOTIFY mainWindowChanged FINAL)

    QObject *m_rightContent = nullptr;
    Q_PROPERTY(QObject *rightContent READ rightContent WRITE setRightContent NOTIFY
                   rightContentChanged FINAL)
};
