#include "sidebarctrl.h"
#include <QVariant>
SidebarCtrl::SidebarCtrl(QObject *parent)
    : QObject{parent}
{}

QObject *SidebarCtrl::fileTreeView() const
{
    return m_fileTreeView;
}

void SidebarCtrl::setFileTreeView(QObject *newFileTreeView)
{
    if (m_fileTreeView == newFileTreeView)
        return;
    m_fileTreeView = newFileTreeView;
    emit fileTreeViewChanged();
}

void SidebarCtrl::openlabel(int index)
{
    m_fileTreeView->setProperty("currentIndex", QVariant(index));
}
