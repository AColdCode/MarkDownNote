#pragma once

#include <QObject>
#include <QDateTime>

class Note : public QObject
{
    Q_OBJECT
public:
    explicit Note(const int &id, const QString &name, QObject *parent = nullptr);

    QJsonObject toJson() const;
    static Note *fromJson(const QJsonObject &obj, QObject *parent = nullptr);
    bool save(const QString &content);

    int id;
    QString m_name;
    QString filePath;
    QString content;
    QDateTime createdTime;
    QDateTime modifiedTime;
    QString attachmentFolder;
    QString signature;

    QString name() const;
    void setName(const QString &newName);

signals:

    void nameChanged();

private:
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
};
