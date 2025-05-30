#include <QQmlProperty>
#include <QFileDialog>
#include <QJsonDocument>
#include <QJsonObject>
#include <QStringList>

#include "notebookctrl.h"
#include "./models/notebook.h"

NoteBookCtrl::NoteBookCtrl(QObject *parent) : QObject{parent}
{
    m_suffixListModel = new SuffixListModel(this);
    QObject::connect(m_suffixListModel,
                     &QAbstractItemModel::dataChanged,
                     this,
                     &NoteBookCtrl::suffixListModelChanged);
}

void NoteBookCtrl::selectRoot(QObject *textField, bool isNewfromFolder)
{
    if (textField == nullptr)
        return;
    QString folder = QFileDialog::getExistingDirectory(nullptr,
                                                       tr("Select Notebook Root Folder"),
                                                       QString(""),
                                                       QFileDialog::ShowDirsOnly
                                                           | QFileDialog::DontResolveSymlinks);

    textField->setProperty("text", folder);

    if (isNewfromFolder)
        QMetaObject::invokeMethod(textField, "accepted", Qt::AutoConnection);
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

void NoteBookCtrl::newFromFolder(const QString &rootPath, QObject *dialog)
{
    if (dialog == nullptr)
        return;
    QDir dir(rootPath);
    if (dir.exists()) {
        QString notebookInfoPath = rootPath + Notebook::notebookInfoDir
                                   + Notebook::notebookInfoFile;
        if (QFile::exists(notebookInfoPath)) {
            dialog->setProperty(
                "hintText",
                tr("The folder is likely to be the root folder of a valid bundle notebook. You may "
                   "want to use \"Open Other Notebooks\" to open it. If continue, all existing "
                   "information of the notebook may be lost."));
        } else {
            dialog->setProperty("hintText", "");
        }
        QFileInfo fileInfo(rootPath);
        dialog->setProperty("nameText", fileInfo.baseName());
        dialog->setProperty("pathText", rootPath);
        QSet<QString> suffixSet;
        collectSuffixesRecursively(dir, suffixSet);
        m_suffixListModel->clear();
        for (const QString &suffix : std::as_const(suffixSet)) {
            m_suffixListModel->addSuffix(suffix);
        }
        emit suffixListModelChanged();
    } else {
        dialog->setProperty("hintText", tr("Please specify a valid folder for the new notebook."));
    }
}

void NoteBookCtrl::openNewNoteDialog()
{
    if (m_noteBook_new == nullptr || m_noteBookMenu == nullptr)
        return;
    QMetaObject::invokeMethod(m_noteBookMenu, "open", Qt::AutoConnection);
    m_noteBook_new->setProperty("visible", true);
}

void NoteBookCtrl::openManageDialog()
{
    if (m_managementNotebook == nullptr || m_noteBookMenu == nullptr)
        return;
    QMetaObject::invokeMethod(m_noteBookMenu, "open", Qt::AutoConnection);
    m_managementNotebook->setProperty("visible", true);
}

QString NoteBookCtrl::currentNotebookName() const
{
    return m_currentNotebookName;
}

void NoteBookCtrl::setCurrentNotebookName(const QString &newCurrentNotebookName)
{
    if (m_currentNotebookName == newCurrentNotebookName)
        return;
    m_currentNotebookName = newCurrentNotebookName;
    emit currentNotebookNameChanged();
}

SuffixListModel *NoteBookCtrl::suffixListModel() const
{
    return m_suffixListModel;
}

void NoteBookCtrl::setSuffixListModel(SuffixListModel *newSuffixListModel)
{
    if (m_suffixListModel == newSuffixListModel)
        return;
    m_suffixListModel = newSuffixListModel;
    emit suffixListModelChanged();
}

QObject *NoteBookCtrl::managementNotebook() const
{
    return m_managementNotebook;
}

void NoteBookCtrl::setManagementNotebook(QObject *newManagementNotebook)
{
    if (m_managementNotebook == newManagementNotebook)
        return;
    m_managementNotebook = newManagementNotebook;
    emit managementNotebookChanged();
}

QObject *NoteBookCtrl::noteBook_new() const
{
    return m_noteBook_new;
}

void NoteBookCtrl::setNoteBook_new(QObject *newNoteBook_new)
{
    if (m_noteBook_new == newNoteBook_new)
        return;
    m_noteBook_new = newNoteBook_new;
    emit noteBook_newChanged();
}

QObject *NoteBookCtrl::noteBookMenu() const
{
    return m_noteBookMenu;
}

void NoteBookCtrl::setNoteBookMenu(QObject *newNoteBookMenu)
{
    if (m_noteBookMenu == newNoteBookMenu)
        return;
    m_noteBookMenu = newNoteBookMenu;
    emit noteBookMenuChanged();
}

void NoteBookCtrl::collectSuffixesRecursively(const QDir &dir, QSet<QString> &suffixSet)
{
    // 获取目录中所有文件
    QFileInfoList files = dir.entryInfoList(QDir::Files | QDir::NoSymLinks);
    for (const QFileInfo &fileInfo : files) {
        QString suffix = fileInfo.suffix().toLower();
        if (!suffix.isEmpty()) {
            suffixSet.insert(suffix);
        }
    }

    // 获取子目录并递归
    QFileInfoList dirs = dir.entryInfoList(QDir::Dirs | QDir::NoDotAndDotDot);
    for (const QFileInfo &subDirInfo : dirs) {
        QDir subDir(subDirInfo.absoluteFilePath());
        collectSuffixesRecursively(subDir, suffixSet);
    }
}
