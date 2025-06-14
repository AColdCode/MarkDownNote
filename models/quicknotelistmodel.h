#pragma once

#include <QAbstractListModel>
#include "quicknotescheme.h"

class QuickNoteListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum QuickNoteRoles { FolderPathRole = Qt::UserRole + 1, NameRole, NoteNameRole };

    explicit QuickNoteListModel(QObject *parent = nullptr);
    ~QuickNoteListModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addScheme(const QString &folderPath,
                               const QString &name,
                               const QString &noteName);
    Q_INVOKABLE void removeAt(int index);
    Q_INVOKABLE bool loadFromJson(const QString &filePath);
    Q_INVOKABLE bool saveToJson(const QString &filePath) const;
    Q_INVOKABLE QString getFolder(const int index);
    Q_INVOKABLE QString getNoteName(const int index);
    Q_INVOKABLE void updateQuickNote(const int index,
                                     const QString &folderPath,
                                     const QString &noteName);

private:
    QList<QuickNoteScheme *> m_quickList;
    QString m_storageFile;
};
