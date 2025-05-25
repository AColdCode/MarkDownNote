#include <QQmlProperty>
#include <QFileDialog>
#include <QDir>
#include <QJsonDocument>
#include <QJsonObject>

#include "notebookctrl.h"
#include "./models/notebook.h"

NoteBookCtrl::NoteBookCtrl(QObject *parent) : QObject{parent} {}

void NoteBookCtrl::selectRoot(QObject *textField)
{
    if (textField == nullptr)
        return;
    QString folder = QFileDialog::getExistingDirectory(nullptr,
                                                       tr("Select Notebook Root Folder"),
                                                       QString(""),
                                                       QFileDialog::ShowDirsOnly
                                                           | QFileDialog::DontResolveSymlinks);

    textField->setProperty("text", folder);
}

void NoteBookCtrl::isLegalPath(const QString &rootPath, QObject *dialog)
{
    if (dialog == nullptr)
        return;
    QDir dir(rootPath);
    if (dir.exists()) {
        QString notebookInfoPath = rootPath + Notebook::notebookInfoDir
                                   + Notebook::notebookInfoFile;
        if (QFile::exists(notebookInfoPath)) {
            QFile file(notebookInfoPath);
            if (file.open(QIODevice::ReadOnly)) {
                QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
                QJsonObject obj = doc.object();
                dialog->setProperty("hintText", QVariant(""));
                dialog->setProperty("descText", obj["description"].toVariant());
                dialog->setProperty("nameText", obj["name"].toVariant());
            } else {
                dialog->setProperty("hintText", QVariant(tr("Not a valid root folder.")));
            }
        } else {
            dialog->setProperty("hintText", QVariant(tr("Not a valid root folder.")));
        }
    } else {
        dialog->setProperty("hintText", QVariant(tr("The root folder specified does not exist.")));
    }
}
