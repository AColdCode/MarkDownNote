#include "markdownctrl.h"
#include "controllers/editorctrl.h"
#include "controllers/expandctrl.h"
#include "controllers/menuctrl.h"
#include "controllers/previewctrl.h"
#include "controllers/notebookctrl.h"
#include "controllers/newnotesctrl.h"
#include "controllers/importmenuctrl.h"
#include "controllers/exportmenuctrl.h"
#include "models/notebooklistmodel.h"

MarkDownCtrl::MarkDownCtrl(QObject *parent)
    : QObject{parent}
    , m_editorCtrl{new EditorCtrl(this)}
    , m_expandCtrl{new ExpandCtrl(this)}
    , m_menuCtrl{new MenuCtrl(this)}
    , m_previewCtrl{new PreviewCtrl(this)}
    , m_noteBookCtrl{new NoteBookCtrl(this)}
    , m_newNotesCtrl{new NewNotesCtrl(this)}
    , m_importMenuCtrl{new ImportMenuCtrl(this)}
    , m_exportMenuCtrl{new ExportMenuCtrl(this)}
    , m_noteBookmodel{new NotebookListModel(this)}
{}

EditorCtrl *MarkDownCtrl::editorCtrl() const
{
    return m_editorCtrl;
}

void MarkDownCtrl::setEditorCtrl(EditorCtrl *newEditorCtrl)
{
    if (m_editorCtrl == newEditorCtrl)
        return;
    m_editorCtrl = newEditorCtrl;
    emit editorCtrlChanged();
}

ExpandCtrl *MarkDownCtrl::expandCtrl() const
{
    return m_expandCtrl;
}

void MarkDownCtrl::setExpandCtrl(ExpandCtrl *newExpandCtrl)
{
    if (m_expandCtrl == newExpandCtrl)
        return;
    m_expandCtrl = newExpandCtrl;
    emit expandCtrlChanged();
}

MenuCtrl *MarkDownCtrl::menuCtrl() const
{
    return m_menuCtrl;
}

void MarkDownCtrl::setmenuCtrl(MenuCtrl *newmenuCtrl)
{
    if (m_menuCtrl == newmenuCtrl)
        return;
    m_menuCtrl = newmenuCtrl;
    emit menuCtrlChanged();
}

PreviewCtrl *MarkDownCtrl::previewCtrl() const
{
    return m_previewCtrl;
}

void MarkDownCtrl::setPreviewCtrl(PreviewCtrl *newPreviewCtrl)
{
    if (m_previewCtrl == newPreviewCtrl)
        return;
    m_previewCtrl = newPreviewCtrl;
    emit previewCtrlChanged();
}

NoteBookCtrl *MarkDownCtrl::noteBookCtrl() const
{
    return m_noteBookCtrl;
}

void MarkDownCtrl::setNoteBookCtrl(NoteBookCtrl *newNoteBookCtrl)
{
    if (m_noteBookCtrl == newNoteBookCtrl)
        return;
    m_noteBookCtrl = newNoteBookCtrl;
    emit noteBookCtrlChanged();
}

NewNotesCtrl *MarkDownCtrl::newNotesCtrl() const
{
    return m_newNotesCtrl;
}

void MarkDownCtrl::setNewNotesCtrl(NewNotesCtrl *newNewNotesCtrl)
{
    if (m_newNotesCtrl == newNewNotesCtrl)
        return;
    m_newNotesCtrl = newNewNotesCtrl;
    emit newNotesCtrlChanged();
}

ImportMenuCtrl *MarkDownCtrl::importMenuCtrl() const
{
    return m_importMenuCtrl;
}

void MarkDownCtrl::setImportMenuCtrl(ImportMenuCtrl *newImportMenuCtrl)
{
    if (m_importMenuCtrl == newImportMenuCtrl)
        return;
    m_importMenuCtrl = newImportMenuCtrl;
    emit importMenuCtrlChanged();
}

ExportMenuCtrl *MarkDownCtrl::exportMenuCtrl() const
{
    return m_exportMenuCtrl;
}

void MarkDownCtrl::setExportMenuCtrl(ExportMenuCtrl *newExportMenuCtrl)
{
    if (m_exportMenuCtrl == newExportMenuCtrl)
        return;
    m_exportMenuCtrl = newExportMenuCtrl;
    emit exportMenuCtrlChanged();
}

NotebookListModel *MarkDownCtrl::noteBookmodel() const
{
    return m_noteBookmodel;
}

void MarkDownCtrl::setNoteBookmodel(NotebookListModel *newNoteBookmodel)
{
    if (m_noteBookmodel == newNoteBookmodel)
        return;
    m_noteBookmodel = newNoteBookmodel;
    emit noteBookmodelChanged();
}
