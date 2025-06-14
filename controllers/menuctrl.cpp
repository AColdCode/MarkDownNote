#include <QQuickWindow>
#include <QProcess>
#include <QTimer>
#include <QMessageBox>

#include "menuctrl.h"

MenuCtrl::MenuCtrl(QObject *parent) : QObject{parent} {}

void MenuCtrl::exitApp()
{
    QQuickWindow *window = qobject_cast<QQuickWindow *>(m_mainWindow);
    if (window) {
        window->close();
    }
}

void MenuCtrl::restartApp()
{
    QString program = QCoreApplication::applicationFilePath();
    QStringList args = QCoreApplication::arguments();

    QProcess::startDetached(program, args);

    // 退出旧进程
    QTimer::singleShot(1000, this, [=]() { QCoreApplication::quit(); });
}

void MenuCtrl::openAboutQt()
{
    QMessageBox::aboutQt(nullptr, tr("About Qt"));
}

QObject *MenuCtrl::mainWindow() const
{
    return m_mainWindow;
}

void MenuCtrl::setMainWindow(QObject *newMainWindow)
{
    if (m_mainWindow == newMainWindow)
        return;
    m_mainWindow = newMainWindow;
    emit mainWindowChanged();
}
