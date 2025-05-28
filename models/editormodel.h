// editormodel.h
#pragma once
#include <QAbstractListModel>
#include "editorentry.h"

class EditorModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum EditorRoles { FileNameRole = Qt::UserRole + 1, FilePathRole, ContentRole };

    explicit EditorModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addEditor(const QString &path, const QString &content);
    Q_INVOKABLE void closeEditor(int index);
    Q_INVOKABLE QString getContent(int index) const;
    Q_INVOKABLE int openFile(const QString &path);

signals:

    void countChanged(int newCount);

private:
    QList<EditorEntry> m_entries;

    int checkFileOpened(const QString &filePath);
};
