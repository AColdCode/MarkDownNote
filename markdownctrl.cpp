#include "markdownctrl.h"

#include <QQuickWindow>
#include <QProcess>
#include <QTimer>

MarkDownCtrl::MarkDownCtrl(QObject *parent) : QObject{parent} {}

void MarkDownCtrl::showFullScreen()
{
    if (m_mainWindow == nullptr) {
        return;
    }

    QMetaObject::invokeMethod(m_mainWindow, "showFullScreen", Qt::AutoConnection);
}

void MarkDownCtrl::exitFullScreen()
{
    if (m_mainWindow == nullptr) {
        return;
    }

    QMetaObject::invokeMethod(m_mainWindow, "showNormal", Qt::AutoConnection);
}

void MarkDownCtrl::staysOnTop()
{
    QQuickWindow *window = qobject_cast<QQuickWindow *>(m_mainWindow);
    if (window) {
        window->setFlag(Qt::WindowStaysOnTopHint, true);
        window->show();
    }
}

void MarkDownCtrl::notStaysOnTop()
{
    QQuickWindow *window = qobject_cast<QQuickWindow *>(m_mainWindow);
    if (window) {
        Qt::WindowFlags flags = window->flags();
        window->setFlags(flags & ~Qt::WindowStaysOnTopHint);
    }
}

void MarkDownCtrl::exitApp()
{
    QQuickWindow *window = qobject_cast<QQuickWindow *>(m_mainWindow);
    if (window) {
        window->close();
    }
}

void MarkDownCtrl::restartApp()
{
    QString program = QCoreApplication::applicationFilePath();
    QStringList args = QCoreApplication::arguments();

    QProcess::startDetached(program, args);

    // 退出旧进程
    QTimer::singleShot(1000, this, [=]() { QCoreApplication::quit(); });
}

void MarkDownCtrl::addNewQuickNoteScheme(const QString name)
{
    if (name.isEmpty() || m_quickAccess == nullptr)
        return;
    QMetaObject::invokeMethod(m_quickAccess,
                              "addQuickNoteScheme",
                              Q_ARG(QVariant, QVariant::fromValue(name)));
}

QObject *MarkDownCtrl::mainWindow() const
{
    return m_mainWindow;
}

void MarkDownCtrl::setMainWindow(QObject *newMainWindow)
{
    if (m_mainWindow == newMainWindow)
        return;
    m_mainWindow = newMainWindow;
    emit mainWindowChanged();
}

QObject *MarkDownCtrl::quickAccess() const
{
    return m_quickAccess;
}

void MarkDownCtrl::setQuickAccess(QObject *newQuickAccess)
{
    if (m_quickAccess == newQuickAccess)
        return;
    m_quickAccess = newQuickAccess;
    emit quickAccessChanged();
}
