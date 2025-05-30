#include <QFileDialog>

#include "newnotesctrl.h"

NewNotesCtrl::NewNotesCtrl(QObject *parent) : QObject{parent} {}

QString NewNotesCtrl::selectFile()
{
    QString file = QFileDialog::getOpenFileName(nullptr, tr("Open File"), "", "All files (*.*)");
    return file;
}
