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

    // 控制菜单区
    Q_INVOKABLE void exitApp();
    Q_INVOKABLE void restartApp();
    Q_INVOKABLE void addNewQuickNoteScheme(const QString name);

    // 传入QML组件
    QObject *mainWindow() const;
    void setMainWindow(QObject *newMainWindow);

    QObject *quickAccess() const;
    void setQuickAccess(QObject *newQuickAccess);

signals:

    void mainWindowChanged();

    void quickAccessChanged();

private:
    QObject *m_mainWindow = nullptr;
    Q_PROPERTY(QObject *mainWindow READ mainWindow WRITE setMainWindow NOTIFY mainWindowChanged FINAL)

    QObject *m_quickAccess = nullptr;
    Q_PROPERTY(
        QObject *quickAccess READ quickAccess WRITE setQuickAccess NOTIFY quickAccessChanged FINAL)
};
