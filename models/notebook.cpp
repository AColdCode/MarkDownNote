#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QFileInfo>
#include <QDir>
#include <QRandomGenerator>

#include "notebook.h"

Notebook::Notebook(const QString &name,
                   const QString &description,
                   const QString &rootPath,
                   QObject *parent)
    : QObject{parent}
    , name{name}
    , description{description}
    , rootPath{rootPath}
{
    createdTime = QDateTime::currentDateTimeUtc();
    modifiedTime = QDateTime::currentDateTimeUtc();
    signature = QString::number(QRandomGenerator::global()->generate())
                + QString::number(QRandomGenerator::global()->generate());

    if (name != "" && !QFile::exists(rootPath + notebookInfoDir + notebookInfoFile)) {
        attachmentFolder = "attachment_folder";
        imageFolder = "image_folder";
        tag_graph = "";
        saveNotebookInfo();
    }

    if (!QFile::exists(rootPath + noteInfoFile))
        save();
}

QJsonObject Notebook::toJson() const
{
    QJsonObject obj;
    obj["name"] = name;
    obj["description"] = description;
    obj["rootPath"] = rootPath;
    return obj;
}

Notebook *Notebook::fromJson(const QJsonObject &obj, QObject *parent)
{
    QDir dir(obj["rootPath"].toString());
    if (!dir.exists())
        return nullptr;

    return new Notebook(obj["name"].toString(),
                        obj["description"].toString(),
                        obj["rootPath"].toString(),
                        parent);
}

Notebook *Notebook::fromPath(const QString &rootPath, QObject *parent)
{
    Notebook *notebook = nullptr;
    if (QFile::exists(rootPath + notebookInfoDir + notebookInfoFile)) {
        QFile file(rootPath + notebookInfoDir + notebookInfoFile);
        if (!file.open(QIODevice::ReadOnly))
            return notebook;
        QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
        QJsonObject obj = doc.object();
        notebook = fromJson(obj, parent);
    } else {
        notebook = new Notebook("", "", rootPath, parent);
    }

    notebook->load();

    return notebook;
}

void Notebook::load()
{
    QFile file(rootPath + noteInfoFile);
    if (!file.open(QIODevice::ReadOnly))
        return;

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonObject obj = doc.object();

    // 加载 notes
    QJsonArray files = obj["files"].toArray();
    for (const QJsonValue &fileVal : files) {
        QJsonObject fileObj = fileVal.toObject();
        maxId = std::max(maxId, fileObj["id"].toInt(-1));
        Note *note = Note::fromJson(fileObj, this);
        notes.append(note);
    }

    // 加载子文件夹作为子 Notebook(无x_notebook文件夹)
    QJsonArray folders = obj["folders"].toArray();
    for (const QJsonValue &folderVal : folders) {
        QString subName = folderVal.toObject()["name"].toString();
        QString subPath = rootPath + "/" + subName;
        if (QFile::exists(subPath + "/vx.json")) {
            Notebook *child = fromPath(subPath, this);
            children.append(child);
        }
    }
}

void Notebook::save()
{
    QJsonObject obj;
    obj["id"] = id;
    obj["created_time"] = createdTime.toString(Qt::ISODate);
    modifiedTime = QDateTime::currentDateTimeUtc();
    obj["modified_time"] = modifiedTime.toString(Qt::ISODate);
    obj["signature"] = signature;
    obj["version"] = version;

    // 保存 notes
    QJsonArray files;
    for (Note *note : notes) {
        files.append(note->toJson());
    }
    obj["files"] = files;

    // 保存子目录信息
    QJsonArray folders;
    for (Notebook *child : children) {
        QJsonObject folderObj;
        folderObj["name"] = QFileInfo(child->rootPath).fileName();
        folders.append(folderObj);
    }
    obj["folders"] = folders;

    QJsonDocument doc(obj);
    QFile file(rootPath + noteInfoFile);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(doc.toJson());
    }
}

void Notebook::saveNotebookInfo()
{
    QDir().mkpath(rootPath + notebookInfoDir);
    QJsonObject obj;
    obj["attachment_folder"] = attachmentFolder;
    obj["created_time"] = createdTime.toString(Qt::ISODate);
    obj["description"] = description;
    obj["image_folder"] = imageFolder;
    obj["name"] = name;
    obj["version"] = version;

    QJsonDocument doc(obj);
    QFile file(rootPath + notebookInfoDir + notebookInfoFile);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(doc.toJson());
    }
}

Note *Notebook::createNote(const QString &name)
{
    QString newId = QString::number(maxId + 1);
    Note *note = new Note(newId, name, this);
    notes.append(note);
    modifiedTime = QDateTime::currentDateTimeUtc();
    return note;
}
