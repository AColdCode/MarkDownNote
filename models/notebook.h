#pragma once

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QAbstractListModel>
#include <QQmlListProperty>

#include "note.h"

class Notebook : public QObject
{
    Q_OBJECT

public:
    Notebook() = default;
    Notebook(const Notebook &) = default;
    ~Notebook() = default;
    Notebook(const QString &name,
             const QString &description,
             const QString &rootPath,
             QObject *parent = nullptr,
             const int id = 1);

    QJsonObject toJson() const;
    static Notebook *fromJson(const QJsonObject &obj, QObject *parent = nullptr);
    static Notebook *fromPath(const QString &rootPath, QObject *parent = nullptr);
    static inline const QString notebookInfoDir = "/vx_notebook";
    static inline const QString notebookInfoFile = "/vx_notebook.json";
    static inline const QString noteInfoFile = "/vx.json";

    void load(); // 从 vx.json 加载
    void save(); // 保存到 vx.json
    void saveNotebookInfo();
    Note *createNote(const QString &name);
    Notebook *createfolder(const QString &name);
    QList<Notebook *> childNotebooks() const;
    void importNotesRecursively(const QString &path, const QStringList &suffixes);
    Note *findNoteByname(const QString &name);
    void updateModifiedTime();
    Note *addNoteWithContent(const QString &name, const QString &content);

    QString m_name;
    QString description;
    QString rootPath;
    int maxId = 1;

    QQmlListProperty<Note> notes();
    Q_INVOKABLE void addNote(Note *note);

    Q_INVOKABLE void addChild(Notebook *child);

    QString name() const;
    void setName(const QString &newName);

signals:
    void notesChanged();

    void nameChanged();

private:
    QList<Note *> m_notes;
    QList<Notebook *> children;

    int version = 1;
    int id = 1;
    QDateTime createdTime;
    QDateTime modifiedTime;
    QString signature;
    QString attachmentFolder;
    QString imageFolder;
    QString tag_graph;

    static qsizetype notesCount(QQmlListProperty<Note> *list);
    static Note *noteAt(QQmlListProperty<Note> *list, qsizetype index);
    Q_PROPERTY(QQmlListProperty<Note> notes READ notes NOTIFY notesChanged FINAL)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
};
