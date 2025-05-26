#pragma once

#include <QObject>

class SidebarCtrl : public QObject
{
    Q_OBJECT
public:
    explicit SidebarCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void openlabel(int index);

    QObject *fileTreeView() const;
    void setFileTreeView(QObject *newFileTreeView);

signals:

    void fileTreeViewChanged();

private:
    QObject *m_fileTreeView = nullptr;
    Q_PROPERTY(QObject *fileTreeView READ fileTreeView WRITE setFileTreeView NOTIFY
                   fileTreeViewChanged FINAL)
};
