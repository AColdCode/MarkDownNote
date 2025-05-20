#include <QFileDialog>

#include "importmenuctrl.h"

ImportMenuCtrl::ImportMenuCtrl(QObject *parent) : QObject{parent} {}

void ImportMenuCtrl::selectFolder(QObject *textField)
{
    if (textField == nullptr)
        return;
    QString folder = QFileDialog::getExistingDirectory(nullptr,
                                                       tr("Import Folder"),
                                                       QString(""),
                                                       QFileDialog::ShowDirsOnly
                                                           | QFileDialog::DontResolveSymlinks);
    textField->setProperty("text", folder);
}

void ImportMenuCtrl::selectFile()
{
    QStringList file = QFileDialog::getOpenFileNames(nullptr,
                                                     tr("Select Files To Import"),
                                                     "",
                                                     "All files (*.*)");
    qDebug() << file;
}
