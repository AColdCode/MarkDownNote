#include <QQmlProperty>
#include <QFileDialog>

#include "notebookctrl.h"

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
