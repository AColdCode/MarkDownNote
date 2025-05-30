#include "sidebarctrl.h"
#include <QVariant>
SidebarCtrl::SidebarCtrl(QObject *parent)
    : QObject{parent}
{}

static const QStringList labelOrder = {"Notebook", "History", "Search", "Snippet"};
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

QObject *SidebarCtrl::resizableBox() const
{
    return m_resizableBox;
}

void SidebarCtrl::setResizableBox(QObject *newResizableBox)
{
    if (m_resizableBox == newResizableBox)
        return;
    m_resizableBox = newResizableBox;
    emit resizableBoxChanged();
}

QObject *SidebarCtrl::sidebar() const
{
    return m_sidebar;
}

void SidebarCtrl::setSidebar(QObject *newSidebar)
{
    if (m_sidebar == newSidebar)
        return;
    m_sidebar = newSidebar;
    emit sidebarChanged();
}

QObject *SidebarCtrl::leftArea() const
{
    return m_leftArea;
}

void SidebarCtrl::setLeftArea(QObject *newLeftArea)
{
    if (m_leftArea == newLeftArea)
        return;
    m_leftArea = newLeftArea;
    emit leftAreaChanged();
}

void SidebarCtrl::openlabel(int index)
{
    m_fileTreeView->setProperty("currentIndex", QVariant(index));
}

void SidebarCtrl::openlocationlist()
{
    bool isVisible = m_resizableBox->property("visible").toBool();
    m_resizableBox->setProperty("visible", !isVisible);
    emit locationlistVisibilityChanged(!isVisible);
}

void SidebarCtrl::showLabelChanged(QString label)
{
    QVariant visibleVar = m_leftArea->property("visible");
    bool isVisible = visibleVar.isValid() && visibleVar.toBool();
    QVariantMap newVisibility = m_sidebar->property("buttonVisibility").toMap();
    bool currentValue = newVisibility.value(label).toBool();
    newVisibility[label] = !currentValue;
    int currentIdx = labelOrder.indexOf(label);
    if (m_sidebar->property("selectedButtonIndex") == currentIdx) {
        int nextindex = fintNextIndex(newVisibility, currentIdx);
        m_sidebar->setProperty("selectedButtonIndex", QVariant(nextindex));
        if (nextindex == -1) {
            m_leftArea->setProperty("visible", false);
        } else {
            openlabel(nextindex);
        }
    }
    m_sidebar->setProperty("buttonVisibility", newVisibility);
    emit labelVisibilityChanged(label, !currentValue);
    if (!isVisible) {
        m_leftArea->setProperty("visible", true);
        openlabel(currentIdx);
        m_sidebar->setProperty("selectedButtonIndex", currentIdx);
    }
}

int SidebarCtrl::fintNextIndex(QVariantMap newVisibility, int currentIdx)
{
    int n = newVisibility.size();
    for (int i = 1; i < n; ++i) {
        int checkIdx = (currentIdx + i) % n;
        QString label = labelOrder[checkIdx];
        if (newVisibility[label].toBool()) {
            return checkIdx;
        }
    }
    return -1;
}
