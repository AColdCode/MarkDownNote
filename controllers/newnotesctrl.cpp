#include <QFileDialog>

#include "newnotesctrl.h"

NewNotesCtrl::NewNotesCtrl(QObject *parent) : QObject{parent} {}

void NewNotesCtrl::selectFile()
{
    QString file = QFileDialog::getOpenFileName(nullptr, tr("Open File"), "", "All files (*.*)");
    qDebug() << file;
}
