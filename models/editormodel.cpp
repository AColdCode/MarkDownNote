// editormodel.cpp
#include "editormodel.h"
#include <QFileInfo>

EditorModel::EditorModel(QObject *parent) : QAbstractListModel(parent) {}

int EditorModel::rowCount(const QModelIndex &) const
{
    return m_entries.count();
}

QVariant EditorModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_entries.count())
        return {};

    const EditorEntry &entry = m_entries[index.row()];
    switch (role) {
    case FileNameRole:
        return entry.fileName;
    case FilePathRole:
        return entry.filePath;
    case ContentRole:
        return entry.content;
    }
    return {};
}

QHash<int, QByteArray> EditorModel::roleNames() const
{
    return {{FileNameRole, "fileName"}, {FilePathRole, "filePath"}, {ContentRole, "content"}};
}

void EditorModel::addEditor(const QString &path, const QString &content)
{
    QFileInfo info(path);
    beginInsertRows(QModelIndex(), m_entries.size(), m_entries.size());
    m_entries.append(EditorEntry(info.fileName(), path, content));
    endInsertRows();
    emit countChanged(m_entries.count());
}

void EditorModel::closeEditor(int index)
{
    if (index < 0 || index >= m_entries.size())
        return;
    beginRemoveRows(QModelIndex(), index, index);
    m_entries.removeAt(index);
    endRemoveRows();
}

QString EditorModel::getContent(int index) const
{
    if (index < 0 || index >= m_entries.size())
        return {};
    return m_entries[index].content;
}

int EditorModel::openFile(const QString &path)
{
    int index = checkFileOpened(path);
    if (index != -1)
        return index;
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return index;
    QTextStream in(&file);
    QString content = in.readAll();
    file.close();
    addEditor(path, content);

    return index;
}

int EditorModel::checkFileOpened(const QString &filePath)
{
    for (int i = 0; i < m_entries.size(); ++i) {
        if (m_entries[i].filePath == filePath) {
            return i;
        }
    }
    return -1;
}
