#pragma once

#include <QObject>

class QuickNoteScheme : public QObject
{
    Q_OBJECT

public:
    explicit QuickNoteScheme(QObject *parent = nullptr);
    QuickNoteScheme(const QString &folderPath,
                    const QString &name,
                    const QString &pattern,
                    QObject *parent = nullptr);

    QString folderPath() const;
    void setFolderPath(const QString &newFolderPath);

    QString name() const;
    void setName(const QString &newName);

    QString noteName() const;
    void setNoteName(const QString &newNoteName);

signals:

    void folderPathChanged();

    void nameChanged();

    void noteNameChanged();

private:
    QString m_folderPath;
    Q_PROPERTY(QString folderPath READ folderPath WRITE setFolderPath NOTIFY folderPathChanged FINAL)

    QString m_name;
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)

    QString m_noteName;
    Q_PROPERTY(QString noteName READ noteName WRITE setNoteName NOTIFY noteNameChanged FINAL)
};
