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
                   const int &maxId,
                   QObject *parent,
                   const int id)
    : QObject{parent}
    , name{name}
    , description{description}
    , rootPath{rootPath}
    , maxId{maxId}
    , id{id}
{
    if (QFile::exists(rootPath + noteInfoFile)) {
        load();
    } else {
        createdTime = QDateTime::currentDateTimeUtc();
        modifiedTime = QDateTime::currentDateTimeUtc();
        signature = QString::number(QRandomGenerator::global()->generate())
                    + QString::number(QRandomGenerator::global()->generate());
    }

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
    obj["maxId"] = maxId;
    return obj;
}

Notebook *Notebook::fromJson(const QJsonObject &obj, QObject *parent)
{
    return new Notebook(obj["name"].toString(),
                        obj["description"].toString(),
                        obj["rootPath"].toString(),
                        obj["maxId"].toInt(),
                        parent);
}

Notebook *Notebook::fromPath(const QString &rootPath, QObject *parent)
{
    Notebook *notebook = nullptr;
    QDir dir(rootPath);
    if (!dir.exists())
        return notebook;

    if (QFile::exists(rootPath + notebookInfoDir + notebookInfoFile)) {
        QFile file(rootPath + notebookInfoDir + notebookInfoFile);
        if (file.open(QIODevice::ReadOnly)) {
            QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
            QJsonObject obj = doc.object();
            notebook = fromJson(obj, parent);
        }
    } else {
        notebook = new Notebook("", "", rootPath, 0, parent);
    }

    return notebook;
}

void Notebook::load()
{
    QFile file(rootPath + noteInfoFile);
    if (!file.open(QIODevice::ReadOnly))
        return;

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonObject obj = doc.object();

    // 加载notebook基本信息
    createdTime = QDateTime::fromString(obj["created_time"].toString(), Qt::ISODate);
    modifiedTime = QDateTime::fromString(obj["modified_time"].toString(), Qt::ISODate);
    signature = obj["signature"].toString();
    id = obj["id"].toInt();
    version = obj["version"].toInt();

    // 加载 notes
    QJsonArray files = obj["files"].toArray();
    for (const QJsonValue &fileVal : files) {
        QJsonObject fileObj = fileVal.toObject();
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
            if (child == nullptr) {
                children.append(child);
            }
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
    Note *note = nullptr;

    int newId = ++maxId;
    QFile file(rootPath + "/" + name + ".md");
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream(&file) << "# " + name;
        note = new Note(newId, name, this);
        notes.append(note);
        modifiedTime = QDateTime::currentDateTimeUtc();
        file.close();
    } else {
        qDebug() << "创建笔记失败";
    }

    return note;
}

Notebook *Notebook::createfolder(const QString &name)
{
    Notebook *folder = nullptr;

    int newId = ++maxId;
    QString newPath = rootPath + "/" + name;
    if (QDir().mkdir(newPath)) {
        folder = new Notebook("", "", newPath, 0, this, newId);
        children.append(folder);
        modifiedTime = QDateTime::currentDateTimeUtc();
    } else {
        qDebug() << "失败：父目录不存在或权限不足";
    }

    return folder;
}
