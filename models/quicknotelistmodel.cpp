#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDir>
#include <QStandardPaths>

#include "quicknotelistmodel.h"

QuickNoteListModel::QuickNoteListModel(QObject *parent) : QAbstractListModel(parent)
{
    QString dataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(dataPath);
    m_storageFile = dataPath + "/quickNotebooks.json";
    loadFromJson(m_storageFile);
}

QuickNoteListModel::~QuickNoteListModel()
{
    qDeleteAll(m_quickList);
}

int QuickNoteListModel::rowCount(const QModelIndex &) const
{
    return m_quickList.size();
}

QVariant QuickNoteListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_quickList.size())
        return QVariant("");
    auto *scheme = m_quickList.at(index.row());
    switch (role) {
    case FolderPathRole:
        return scheme->folderPath();
    case NameRole:
        return scheme->name();
    case NoteNameRole:
        return scheme->noteName();
    default:
        return QVariant("");
    }
}

QHash<int, QByteArray> QuickNoteListModel::roleNames() const
{
    return {{FolderPathRole, "folderPath"}, {NameRole, "name"}, {NoteNameRole, "noteName"}};
}

void QuickNoteListModel::addScheme(const QString &folderPath,
                                   const QString &name,
                                   const QString &noteName)
{
    beginInsertRows(QModelIndex(), m_quickList.size(), m_quickList.size());
    auto *scheme = new QuickNoteScheme(this);
    scheme->setFolderPath(folderPath);
    scheme->setName(name);
    scheme->setNoteName(noteName);
    m_quickList.append(scheme);
    endInsertRows();

    saveToJson(m_storageFile);
}

void QuickNoteListModel::removeAt(int index)
{
    if (index < 0 || index >= m_quickList.size())
        return;
    beginRemoveRows(QModelIndex(), index, index);
    delete m_quickList.takeAt(index);
    endRemoveRows();

    saveToJson(m_storageFile);
}

bool QuickNoteListModel::loadFromJson(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly))
        return false;

    QByteArray data = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    if (!doc.isArray())
        return false;

    beginResetModel();
    qDeleteAll(m_quickList);
    m_quickList.clear();

    for (const auto &value : doc.array()) {
        QJsonObject obj = value.toObject();
        auto *note = new QuickNoteScheme(obj["folder_path"].toString(),
                                         obj["name"].toString(),
                                         obj["note_name"].toString(),
                                         this);
        m_quickList.append(note);
    }
    endResetModel();
    return true;
}

bool QuickNoteListModel::saveToJson(const QString &filePath) const
{
    QJsonArray array;
    for (const auto *note : m_quickList) {
        QJsonObject obj;
        obj["folder_path"] = note->folderPath();
        obj["name"] = note->name();
        obj["note_name"] = note->noteName();
        array.append(obj);
    }

    QJsonDocument doc(array);
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly))
        return false;

    file.write(doc.toJson());
    file.close();
    return true;
}

QString QuickNoteListModel::getFolder(const int index)
{
    if (index < 0 || index >= m_quickList.size())
        return "";
    return m_quickList[index]->folderPath();
}

QString QuickNoteListModel::getNoteName(const int index)
{
    if (index < 0 || index >= m_quickList.size())
        return "";
    return m_quickList[index]->noteName();
}

void QuickNoteListModel::updateQuickNote(const int index,
                                         const QString &folderPath,
                                         const QString &noteName)
{
    if (index < 0 || index >= m_quickList.size())
        return;
    m_quickList[index]->setFolderPath(folderPath);
    m_quickList[index]->setNoteName(noteName);
}
