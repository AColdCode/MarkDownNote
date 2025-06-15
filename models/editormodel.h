#pragma once
#include <QAbstractListModel>
#include "note.h"

class EditorModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum EditorRoles { FileNameRole = Qt::UserRole + 1, FilePathRole, ContentRole };

    explicit EditorModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addEditor(Note *entry);
    Q_INVOKABLE void closeEditor(int index, int currentIndex);
    Q_INVOKABLE QString getContent(int index) const;
    Q_INVOKABLE int openFile(Note *entry);
    Q_INVOKABLE bool saveCurrentEditor(const int index, const QString &content);
    Q_INVOKABLE void editorModified(int index, bool modified);
    Q_INVOKABLE int count();

    QObject *tabName_repeater() const;
    void setTabName_repeater(QObject *newTabName_repeater);

signals:

    void countChanged(int newCount);

    void frontEditorClosed();

    void firstEditorClose();

    void tabName_repeaterChanged();

private:
    QList<Note *> m_entries;

    int checkFileOpened(const QString &filePath);

    QObject *m_tabName_repeater = nullptr;
    Q_PROPERTY(QObject *tabName_repeater READ tabName_repeater WRITE setTabName_repeater NOTIFY
                   tabName_repeaterChanged FINAL)
};
