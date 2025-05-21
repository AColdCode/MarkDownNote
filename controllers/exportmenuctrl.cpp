#include <QFileDialog>

#include "exportmenuctrl.h"

ExportMenuCtrl::ExportMenuCtrl(QObject *parent) : QObject{parent} {}

void ExportMenuCtrl::selectFolder(QObject *textField)
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
