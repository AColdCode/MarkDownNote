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

    const Note *entry = m_entries[index.row()];
    switch (role) {
    case FileNameRole:
        return entry->m_name;
    case FilePathRole:
        return entry->filePath;
    case ContentRole:
        return entry->content;
    }
    return {};
}

QHash<int, QByteArray> EditorModel::roleNames() const
{
    return {{FileNameRole, "fileName"}, {FilePathRole, "filePath"}, {ContentRole, "content"}};
}

void EditorModel::addEditor(Note *entry)
{
    beginInsertRows(QModelIndex(), m_entries.size(), m_entries.size());
    m_entries.append(entry);
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
    return m_entries[index]->content;
}

int EditorModel::openFile(Note *entry)
{
    if (entry == nullptr)
        return -1;
    QString path = entry->filePath;
    int index = checkFileOpened(path);
    if (index != -1)
        return index;
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return index;
    QTextStream in(&file);
    QString content = in.readAll();
    entry->content = content;
    file.close();
    addEditor(entry);

    return index;
}

void EditorModel::saveCurrentEditor(const int index, const QString &content)
{
    if (index < 0 || index >= m_entries.size())
        return;
    Note *entry = m_entries[index];
    entry->save(content);
}

void EditorModel::editorModified(int index, bool modified)
{
    if (m_tabName_repeater == nullptr)
        return;
    QMetaObject::invokeMethod(m_tabName_repeater,
                              "editorModified",
                              Q_ARG(QVariant, QVariant(index)),
                              Q_ARG(QVariant, QVariant(modified)));
}

int EditorModel::checkFileOpened(const QString &filePath)
{
    for (int i = 0; i < m_entries.size(); ++i) {
        if (m_entries[i]->filePath == filePath) {
            return i;
        }
    }
    return -1;
}

QObject *EditorModel::tabName_repeater() const
{
    return m_tabName_repeater;
}

void EditorModel::setTabName_repeater(QObject *newTabName_repeater)
{
    if (m_tabName_repeater == newTabName_repeater)
        return;
    m_tabName_repeater = newTabName_repeater;
    emit tabName_repeaterChanged();
}
