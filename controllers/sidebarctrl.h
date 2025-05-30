#pragma once

#include <QObject>

class SidebarCtrl : public QObject
{
    Q_OBJECT
public:
    explicit SidebarCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void openlabel(int index);
    Q_INVOKABLE void openlocationlist();
    Q_INVOKABLE void showLabelChanged(QString label);

    int fintNextIndex(QVariantMap newVisibility, int currentIdx);

    QObject *fileTreeView() const;
    void setFileTreeView(QObject *newFileTreeView);

    QObject *resizableBox() const;
    void setResizableBox(QObject *newResizableBox);

    QObject *sidebar() const;
    void setSidebar(QObject *newSidebar);

    QObject *leftArea() const;
    void setLeftArea(QObject *newLeftArea);

signals:

    void fileTreeViewChanged();

    void resizableBoxChanged();

    void labelVisibilityChanged(const QString &label, bool visible);

    void locationlistVisibilityChanged(bool visible);

    void sidebarChanged();

    void leftAreaChanged();

private:
    QObject *m_fileTreeView = nullptr;
    QObject *m_resizableBox = nullptr;
    QObject *m_sidebar = nullptr;
    QObject *m_leftArea = nullptr;

    Q_PROPERTY(QObject *fileTreeView READ fileTreeView WRITE setFileTreeView NOTIFY
                   fileTreeViewChanged FINAL)
    Q_PROPERTY(QObject *resizableBox READ resizableBox WRITE setResizableBox NOTIFY
                   resizableBoxChanged FINAL)

    Q_PROPERTY(QObject *sidebar READ sidebar WRITE setSidebar NOTIFY sidebarChanged FINAL)
    Q_PROPERTY(QObject *leftArea READ leftArea WRITE setLeftArea NOTIFY leftAreaChanged FINAL)
};
