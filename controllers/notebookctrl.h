#pragma once

#include <QObject>
#include <QDir>

#include "./models/suffixlistmodel.h"

Q_DECLARE_METATYPE(SuffixListModel *)

class NoteBookCtrl : public QObject
{
    Q_OBJECT
public:
    explicit NoteBookCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void selectRoot(QObject *textField, bool isNewfromFolder = false);
    Q_INVOKABLE void isLegalPath(const QString &rootPath, QObject *dialog);
    Q_INVOKABLE void newFromFolder(const QString &rootPath, QObject *dialog);

    QString currentNotebookName() const;
    void setCurrentNotebookName(const QString &newCurrentNotebookName);

    SuffixListModel *suffixListModel() const;
    void setSuffixListModel(SuffixListModel *newSuffixListModel);

signals:

    void currentNotebookNameChanged();

    void suffixListModelChanged();

private:
    QString m_currentNotebookName;
    Q_PROPERTY(QString currentNotebookName READ currentNotebookName WRITE setCurrentNotebookName
                   NOTIFY currentNotebookNameChanged FINAL)

    SuffixListModel *m_suffixListModel = nullptr;
    Q_PROPERTY(SuffixListModel *suffixListModel READ suffixListModel WRITE setSuffixListModel NOTIFY
                   suffixListModelChanged FINAL)

    void collectSuffixesRecursively(const QDir &dir, QSet<QString> &suffixSet);
};
