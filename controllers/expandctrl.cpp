#include <QQuickWindow>

#include "expandctrl.h"

ExpandCtrl::ExpandCtrl(QObject *parent) : QObject{parent} {}

void ExpandCtrl::showFullScreen()
{
    if (m_mainWindow == nullptr) {
        return;
    }

    QMetaObject::invokeMethod(m_mainWindow, "showFullScreen", Qt::AutoConnection);
}

void ExpandCtrl::exitFullScreen()
{
    if (m_mainWindow == nullptr) {
        return;
    }

    QMetaObject::invokeMethod(m_mainWindow, "showNormal", Qt::AutoConnection);
}

void ExpandCtrl::staysOnTop()
{
    QQuickWindow *window = qobject_cast<QQuickWindow *>(m_mainWindow);
    if (window) {
        window->setFlag(Qt::WindowStaysOnTopHint, true);
        window->show();
    }
}

void ExpandCtrl::notStaysOnTop()
{
    QQuickWindow *window = qobject_cast<QQuickWindow *>(m_mainWindow);
    if (window) {
        Qt::WindowFlags flags = window->flags();
        window->setFlags(flags & ~Qt::WindowStaysOnTopHint);
    }
}

void ExpandCtrl::expendContent(bool selected)
{
    if (m_sidebar == nullptr)
        return;
    if (selected) {
        m_sidebar->setProperty("visible", false);
    } else {
        m_sidebar->setProperty("visible", true);
    }
}

QObject *ExpandCtrl::mainWindow() const
{
    return m_mainWindow;
}

void ExpandCtrl::setMainWindow(QObject *newMainWindow)
{
    if (m_mainWindow == newMainWindow)
        return;
    m_mainWindow = newMainWindow;
    emit mainWindowChanged();
}

QObject *ExpandCtrl::sidebar() const
{
    return m_sidebar;
}

void ExpandCtrl::setSidebar(QObject *newSidebar)
{
    if (m_sidebar == newSidebar)
        return;
    m_sidebar = newSidebar;
    emit sidebarChanged();
}
