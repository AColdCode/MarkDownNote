#pragma once

#include <QObject>
#include <QString>
#include <QJsonObject>

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
             QObject *parent = nullptr);

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
    QList<Notebook *> childNotebooks() const;

    QString name;
    QString description;
    QString rootPath;

private:
    QList<Note *> notes;
    QList<Notebook *> children;

    int version = 1;
    int maxId = -1;
    int id = 1;
    QDateTime createdTime;
    QDateTime modifiedTime;
    QString signature;
    QString attachmentFolder;
    QString imageFolder;
    QString tag_graph;
};
