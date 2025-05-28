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
                   QObject *parent,
                   const int id)
    : QObject{parent}
    , m_name{name}
    , description{description}
    , rootPath{rootPath}
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

    if (m_name != "" && !QFile::exists(rootPath + notebookInfoDir + notebookInfoFile)) {
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
    obj["name"] = m_name;
    obj["description"] = description;
    obj["rootPath"] = rootPath;
    return obj;
}

Notebook *Notebook::fromJson(const QJsonObject &obj, QObject *parent)
{
    Notebook *notebook = new Notebook(obj["name"].toString(),
                                      obj["description"].toString(),
                                      obj["rootPath"].toString(),
                                      parent);
    notebook->maxId = obj["maxId"].toInt();
    return notebook;
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
        notebook = new Notebook("", "", rootPath, parent);
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

    // 加载 m_notes
    QJsonArray files = obj["files"].toArray();
    for (const QJsonValue &fileVal : files) {
        QJsonObject fileObj = fileVal.toObject();
        Note *note = Note::fromJson(fileObj, this);
        m_notes.append(note);
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

    // 保存 m_notes
    QJsonArray files;
    for (Note *note : m_notes) {
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
    QDir dir(rootPath + notebookInfoDir);
    if (!dir.exists())
        QDir().mkpath(rootPath + notebookInfoDir);
    QJsonObject obj;
    obj["attachment_folder"] = attachmentFolder;
    obj["created_time"] = createdTime.toString(Qt::ISODate);
    obj["description"] = description;
    obj["image_folder"] = imageFolder;
    obj["name"] = m_name;
    obj["version"] = version;
    obj["rootPath"] = rootPath;
    obj["maxId"] = maxId;

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
    QFile file(rootPath + "/" + name);
    QFileInfo info(name);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        if (info.suffix() == "md")
            QTextStream(&file) << "# " + info.completeBaseName();
        note = new Note(newId, name, this);
        m_notes.append(note);
        emit notesChanged();
        modifiedTime = QDateTime::currentDateTimeUtc();
        save();
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
        folder = new Notebook("", "", newPath, this, newId);
        children.append(folder);
        modifiedTime = QDateTime::currentDateTimeUtc();
        save();
    } else {
        qDebug() << "失败：父目录不存在或权限不足";
    }

    return folder;
}

QQmlListProperty<Note> Notebook::notes()
{
    return QQmlListProperty<Note>(this, this, &Notebook::notesCount, &Notebook::noteAt);
}

void Notebook::addNote(Note *note)
{
    m_notes.append(note);
    emit notesChanged();
}

void Notebook::addChild(Notebook *child)
{
    children.append(child);
}

QString Notebook::name() const
{
    return m_name;
}

void Notebook::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}

qsizetype Notebook::notesCount(QQmlListProperty<Note> *list)
{
    return static_cast<Notebook *>(list->data)->m_notes.count();
}

Note *Notebook::noteAt(QQmlListProperty<Note> *list, qsizetype index)
{
    return static_cast<Notebook *>(list->data)->m_notes.at(index);
}

void Notebook::importNotesRecursively(const QString &path, const QStringList &suffixes)
{
    QDir dir(path);
    QFileInfoList entries = dir.entryInfoList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);

    for (const QFileInfo &info : entries) {
        if (info.isDir()) {
            // 子目录 -> 子Notebook
            if ("/" + info.baseName() == notebookInfoDir)
                continue;
            QFile file(info.absoluteFilePath() + noteInfoFile);
            if (file.exists())
                file.remove();
            Notebook *child = new Notebook("", "", info.absoluteFilePath(), this, ++maxId);
            child->importNotesRecursively(info.absoluteFilePath(), suffixes);
            addChild(child);
        } else if (info.isFile()) {
            // 检查文件后缀
            QString suffix = info.suffix();
            if (suffixes.contains(suffix)) {
                Note *note = new Note(++maxId, info.fileName(), this);
                addNote(note);
            }
        }
    }
    save();
}

Note *Notebook::findNoteByname(const QString &name)
{
    for (Note *note : m_notes) {
        if (note->m_name == name)
            return note;
    }

    return nullptr;
}

void Notebook::updateModifiedTime()
{
    save();
    modifiedTime = QDateTime::currentDateTimeUtc();
    saveNotebookInfo();
}
