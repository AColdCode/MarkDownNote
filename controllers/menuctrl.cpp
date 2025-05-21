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

void MenuCtrl::addNewQuickNoteScheme(const QString name)
{
    if (name.isEmpty() || m_quickAccess == nullptr)
        return;
    QMetaObject::invokeMethod(m_quickAccess,
                              "addQuickNoteScheme",
                              Q_ARG(QVariant, QVariant::fromValue(name)));
}

void MenuCtrl::openAboutQt()
{
    QMessageBox::aboutQt(nullptr, tr("About Qt"));
}

QObject *MenuCtrl::quickAccess() const
{
    return m_quickAccess;
}

void MenuCtrl::setQuickAccess(QObject *newQuickAccess)
{
    if (m_quickAccess == newQuickAccess)
        return;
    m_quickAccess = newQuickAccess;
    emit quickAccessChanged();
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
