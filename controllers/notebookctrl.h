#pragma once

#include <QObject>

class NoteBookCtrl : public QObject
{
    Q_OBJECT
public:
    explicit NoteBookCtrl(QObject *parent = nullptr);

    Q_INVOKABLE void selectRoot(QObject *textField);
    Q_INVOKABLE void isLegalPath(const QString &rootPath, QObject *dialog);

    QString currentNotebookName() const;
    void setCurrentNotebookName(const QString &newCurrentNotebookName);

signals:

    void currentNotebookNameChanged();

private:
    QString m_currentNotebookName;
    Q_PROPERTY(QString currentNotebookName READ currentNotebookName WRITE setCurrentNotebookName
                   NOTIFY currentNotebookNameChanged FINAL)
};
