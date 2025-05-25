#include <QDateTime>
#include <QJsonObject>
#include <QRandomGenerator>
#include <QJsonArray>

#include "note.h"

Note::Note(const int &id, const QString &name, QObject *parent)
    : QObject{parent}
    , id{id}
    , m_name{name}
{
    createdTime = QDateTime::currentDateTimeUtc();
    modifiedTime = createdTime;
    attachmentFolder = "";
    signature = QString::number(QRandomGenerator::global()->generate())
                + QString::number(QRandomGenerator::global()->generate());
}

QJsonObject Note::toJson() const
{
    QJsonObject obj;
    obj["id"] = id;
    obj["name"] = m_name;
    obj["created_time"] = createdTime.toString(Qt::ISODate);
    obj["modified_time"] = modifiedTime.toString(Qt::ISODate);
    obj["attachment_folder"] = attachmentFolder;
    obj["signature"] = signature;
    obj["tags"] = QJsonArray();
    return obj;
}

Note *Note::fromJson(const QJsonObject &obj, QObject *parent)
{
    Note *note = new Note(obj["id"].toInt(), obj["name"].toString(), parent);
    note->createdTime = QDateTime::fromString(obj["created_time"].toString(), Qt::ISODate);
    note->modifiedTime = QDateTime::fromString(obj["modified_time"].toString(), Qt::ISODate);
    note->attachmentFolder = obj["attachment_folder"].toString();
    note->signature = obj["signature"].toString();
    return note;
}

QString Note::name() const
{
    return m_name;
}

void Note::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}
