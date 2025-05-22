#pragma once

#include <QObject>

class Note : public QObject
{
    Q_OBJECT
public:
    explicit Note(const QString &id, const QString &name, QObject *parent = nullptr);

    QJsonObject toJson() const;
    static Note *fromJson(const QJsonObject &obj, QObject *parent = nullptr);

    QString id;
    QString name;
    QDateTime createdTime;
    QDateTime modifiedTime;
    QString attachmentFolder;
    QString signature;

signals:
};
