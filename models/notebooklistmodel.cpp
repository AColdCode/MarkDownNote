#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDir>
#include <QStandardPaths>

#include "notebooklistmodel.h"

NotebookListModel::NotebookListModel(QObject *parent) : QAbstractListModel(parent)
{
    QString dataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(dataPath);
    m_storageFile = dataPath + "/notebooks.json";
    load();
}

int NotebookListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_notebooks.count();
}

QVariant NotebookListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_notebooks.size())
        return {};

    const Notebook *notebook = m_notebooks[index.row()];
    switch (role) {
    case NameRole:
        return notebook->name;
    case DescriptionRole:
        return notebook->description;
    case PathRole:
        return notebook->rootPath;
    case MaxIdRole:
        return notebook->maxId;
    default:
        return {};
    }
}

QHash<int, QByteArray> NotebookListModel::roleNames() const
{
    return {{NameRole, "name"},
            {DescriptionRole, "description"},
            {PathRole, "rootPath"},
            {MaxIdRole, "maxId"}};
}

void NotebookListModel::addNotebook(Notebook *notebook)
{
    beginInsertRows(QModelIndex(), m_notebooks.count(), m_notebooks.count());
    m_notebooks.append(notebook);
    endInsertRows();
    save();
}

void NotebookListModel::addNotebookByinfo(const QString &name,
                                          const QString &desc,
                                          const QString &path,
                                          const int &maxId)
{
    if (name == "" || path == "")
        return;
    addNotebook(new Notebook(name, desc, path, maxId, this));
}

void NotebookListModel::clear()
{
    beginResetModel();
    m_notebooks.clear();
    endResetModel();
    save();
}

void NotebookListModel::save()
{
    QFile file(m_storageFile);
    if (!file.open(QIODevice::WriteOnly))
        return;

    QJsonArray array;
    for (Notebook *nb : m_notebooks) {
        array.append(nb->toJson());
    }

    QJsonDocument doc(array);
    file.write(doc.toJson());
}

void NotebookListModel::load()
{
    QFile file(m_storageFile);
    if (!file.open(QIODevice::ReadOnly))
        return;

    QByteArray data = file.readAll();
    QJsonDocument doc = QJsonDocument::fromJson(data);
    QJsonArray array = doc.array();

    clear();
    for (const auto &item : array) {
        QString rootPath = item.toObject()["rootPath"].toString();
        Notebook *notebook = Notebook::fromPath(rootPath, this);
        if (notebook != nullptr)
            addNotebook(notebook);
    }
}

bool NotebookListModel::updateNotebook(int row, Notebook *notebook)
{
    if (row < 0 || row >= m_notebooks.size())
        return false;

    m_notebooks[row] = notebook;
    QModelIndex idx = createIndex(row, 0);
    emit dataChanged(idx, idx, {NameRole, DescriptionRole, PathRole, MaxIdRole});
    save();
    return true;
}

bool NotebookListModel::NotebookListModel::removeRow(int row)
{
    if (row < 0 || row >= m_notebooks.size())
        return false;

    beginRemoveRows(QModelIndex(), row, row);
    m_notebooks.removeAt(row);
    endRemoveRows();
    save();
    return true;
}
