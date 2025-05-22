#pragma once

#include <QAbstractListModel>
#include "notebook.h"

class NotebookListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles { NameRole = Qt::UserRole + 1, DescriptionRole, PathRole, MaxIdRole };

    explicit NotebookListModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addNotebook(Notebook *notebook);
    Q_INVOKABLE void addNotebookByinfo(const QString &name,
                                       const QString &desc,
                                       const QString &path,
                                       const int &maxId = 0);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void save();
    Q_INVOKABLE void load();
    Q_INVOKABLE bool updateNotebook(int row, Notebook *notebook);
    Q_INVOKABLE bool removeRow(int row);

private:
    QList<Notebook *> m_notebooks;
    QString m_storageFile;
};
