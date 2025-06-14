#pragma once

#include <QAbstractListModel>
#include "notebook.h"
#include "suffixitem.h"

class NotebookListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles { NameRole = Qt::UserRole + 1, DescriptionRole, PathRole };

    explicit NotebookListModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addNotebook(Notebook *notebook);
    Q_INVOKABLE QVariant addNotebookByinfo(const QString &name,
                                           const QString &desc,
                                           const QString &path,
                                           QObject *hint_area = nullptr);
    Q_INVOKABLE void addNotebookFromPath(const QString &rootPath);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void save();
    Q_INVOKABLE void load();
    Q_INVOKABLE bool updateNotebook(int row, Notebook *notebook);
    Q_INVOKABLE bool updateNotebook(const int row, const QString &name, const QString &desc);
    Q_INVOKABLE bool removeRow(int row);
    Q_INVOKABLE void isExistNotebook(const QString &rootPath, QObject *dialog);
    Q_INVOKABLE Notebook *getNotebookByIndex(int index);
    Q_INVOKABLE void createNewNote(const QString &name);
    Q_INVOKABLE void newNoteBookFromFolder(const QString &name,
                                           const QString &desc,
                                           const QString &rootPath,
                                           const QStringList &suffixes);
    Q_INVOKABLE void openFile(const QString &filePath);
    Q_INVOKABLE void openFolder(const QString &path);
    Q_INVOKABLE int count();
    Q_INVOKABLE QString currentNotebookPath();
    Q_INVOKABLE void createQuickNote(const QString &noteName);

    Notebook *currentNotebook() const;
    void setCurrentNotebook(Notebook *newCurrentNotebook);

signals:
    void addCountChanged(int newCount);

    void lostCountChanged(int newCount);

    void currentNotebookChanged();

    void updateNoteModel();

private:
    QList<Notebook *> m_notebooks;
    QString m_storageFile;

    Notebook *m_currentNotebook = nullptr;
    Q_PROPERTY(Notebook *currentNotebook READ currentNotebook WRITE setCurrentNotebook NOTIFY
                   currentNotebookChanged FINAL)
};
