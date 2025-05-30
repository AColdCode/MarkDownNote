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
    Q_INVOKABLE void openNewNoteDialog();
    Q_INVOKABLE void openManageDialog();

    QString currentNotebookName() const;
    void setCurrentNotebookName(const QString &newCurrentNotebookName);

    SuffixListModel *suffixListModel() const;
    void setSuffixListModel(SuffixListModel *newSuffixListModel);

    QObject *managementNotebook() const;
    void setManagementNotebook(QObject *newManagementNotebook);

    QObject *noteBook_new() const;
    void setNoteBook_new(QObject *newNoteBook_new);

    QObject *noteBookMenu() const;
    void setNoteBookMenu(QObject *newNoteBookMenu);

signals:

    void currentNotebookNameChanged();

    void suffixListModelChanged();

    void managementNotebookChanged();

    void noteBook_newChanged();

    void noteBookMenuChanged();

private:
    QString m_currentNotebookName;
    Q_PROPERTY(QString currentNotebookName READ currentNotebookName WRITE setCurrentNotebookName
                   NOTIFY currentNotebookNameChanged FINAL)

    SuffixListModel *m_suffixListModel = nullptr;
    Q_PROPERTY(SuffixListModel *suffixListModel READ suffixListModel WRITE setSuffixListModel NOTIFY
                   suffixListModelChanged FINAL)

    QObject *m_managementNotebook = nullptr;
    Q_PROPERTY(QObject *managementNotebook READ managementNotebook WRITE setManagementNotebook
                   NOTIFY managementNotebookChanged FINAL)

    QObject *m_noteBook_new = nullptr;
    Q_PROPERTY(QObject *noteBook_new READ noteBook_new WRITE setNoteBook_new NOTIFY
                   noteBook_newChanged FINAL)

    QObject *m_noteBookMenu = nullptr;
    Q_PROPERTY(QObject *noteBookMenu READ noteBookMenu WRITE setNoteBookMenu NOTIFY
                   noteBookMenuChanged FINAL)

    void collectSuffixesRecursively(const QDir &dir, QSet<QString> &suffixSet);
};
