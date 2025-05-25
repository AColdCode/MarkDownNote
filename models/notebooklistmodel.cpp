#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDir>
#include <QQmlProperty>
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
        return notebook->m_name;
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
    emit countChanged(m_notebooks.count());
}

QVariant NotebookListModel::addNotebookByinfo(const QString &name,
                                              const QString &desc,
                                              const QString &path,
                                              QObject *hint_area,
                                              const int &maxId)
{
    if (name == "") {
        if (hint_area != nullptr)
            hint_area->setProperty("text", tr("Please specify a name for the notebook."));
        return false;
    }

    if (path == "") {
        if (hint_area != nullptr)
            hint_area->setProperty("text",
                                   tr("Please specify a valid root folder for the notebook."));
        return false;
    } else {
        QDir dir(path);
        if (dir.exists()) {
            if (!dir.isEmpty()) {
                hint_area->setProperty(
                    "text",
                    tr("Root folder of the notebook must be empty. If you want " "to import " "exi" "s" "ting" " dat" "a, " "please try other " "operations."));
                return false;
            }
        } else
            dir.mkpath(path);
    }
    addNotebook(new Notebook(name, desc, path, maxId, this));

    return true;
}

void NotebookListModel::addNotebookFromPath(const QString &rootPath)
{
    Notebook *notebook = Notebook::fromPath(rootPath, this);
    if (notebook != nullptr)
        addNotebook(notebook);
    save();
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
    if (!m_notebooks.isEmpty())
        setCurrentNotebook(m_notebooks.at(0));
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

void NotebookListModel::isExistNotebook(const QString &rootPath, QObject *dialog)
{
    auto it = std::find_if(m_notebooks.begin(), m_notebooks.end(), [&rootPath](Notebook *nb) {
        return nb->rootPath == rootPath;
    });
    if (it != m_notebooks.end()) {
        dialog->setProperty("hintText",
                            tr("There already exists a notebook (") + (*it)->m_name
                                + tr(") with the same root folder."));
    } else {
        dialog->setProperty("okEnable", QVariant(true));
    }
}

Notebook *NotebookListModel::getNotebookByIndex(int index)
{
    return m_notebooks.at(index);
}

void NotebookListModel::createNewNote(const QString &name)
{
    if (m_currentNotebook == nullptr)
        return;
    Note *note = m_currentNotebook->createNote(name);
    if (note != nullptr) {
        emit updateNoteModel();
    }
}

Notebook *NotebookListModel::currentNotebook() const
{
    return m_currentNotebook;
}

void NotebookListModel::setCurrentNotebook(Notebook *newCurrentNotebook)
{
    if (m_currentNotebook == newCurrentNotebook)
        return;
    m_currentNotebook = newCurrentNotebook;
    emit currentNotebookChanged();
}
