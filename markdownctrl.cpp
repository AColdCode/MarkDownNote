#include "markdownctrl.h"

#include <QQuickWindow>

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
