#pragma once

#include <QObject>
#include <QQmlEngine>

#include <models/notebooklistmodel.h>

class ExpandCtrl;
class EditorCtrl;
class MenuCtrl;
class PreviewCtrl;
class NoteBookCtrl;
class NewNotesCtrl;
class ImportMenuCtrl;
class ExportMenuCtrl;

class SidebarCtrl;

class TopbarCtrl;

class MarkDownCtrl : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_NAMED_ELEMENT(MarkDownCtrl)

public:
    explicit MarkDownCtrl(QObject *parent = nullptr);

    EditorCtrl *editorCtrl() const;
    void setEditorCtrl(EditorCtrl *newEditorCtrl);

    ExpandCtrl *expandCtrl() const;
    void setExpandCtrl(ExpandCtrl *newExpandCtrl);

    MenuCtrl *menuCtrl() const;
    void setmenuCtrl(MenuCtrl *newmenuCtrl);

    PreviewCtrl *previewCtrl() const;
    void setPreviewCtrl(PreviewCtrl *newPreviewCtrl);

    NoteBookCtrl *noteBookCtrl() const;
    void setNoteBookCtrl(NoteBookCtrl *newNoteBookCtrl);

    NewNotesCtrl *newNotesCtrl() const;
    void setNewNotesCtrl(NewNotesCtrl *newNewNotesCtrl);

    ImportMenuCtrl *importMenuCtrl() const;
    void setImportMenuCtrl(ImportMenuCtrl *newImportMenuCtrl);

    ExportMenuCtrl *exportMenuCtrl() const;
    void setExportMenuCtrl(ExportMenuCtrl *newExportMenuCtrl);

    NotebookListModel *noteBookmodel() const;
    void setNoteBookmodel(NotebookListModel *newNoteBookmodel);

    SidebarCtrl *sidebarCtrl() const;
    void setSidebarCtrl(SidebarCtrl *newSidebarCtrl);

    TopbarCtrl *topbarCtrl() const;
    void setTopbarCtrl(TopbarCtrl *newTopbarCtrl);

signals:
    void editorCtrlChanged();

    void expandCtrlChanged();

    void menuCtrlChanged();

    void previewCtrlChanged();

    void noteBookCtrlChanged();

    void newNotesCtrlChanged();

    void importMenuCtrlChanged();

    void exportMenuCtrlChanged();

    void noteBookmodelChanged();

    void sidebarCtrlChanged();

    void topbarCtrlChanged();

private:
    ExpandCtrl *m_expandCtrl = nullptr;
    Q_PROPERTY(
        ExpandCtrl *expandCtrl READ expandCtrl WRITE setExpandCtrl NOTIFY expandCtrlChanged FINAL)

    EditorCtrl *m_editorCtrl = nullptr;
    Q_PROPERTY(
        EditorCtrl *editorCtrl READ editorCtrl WRITE setEditorCtrl NOTIFY editorCtrlChanged FINAL)

    MenuCtrl *m_menuCtrl = nullptr;
    Q_PROPERTY(MenuCtrl *menuCtrl READ menuCtrl WRITE setmenuCtrl NOTIFY menuCtrlChanged FINAL)

    PreviewCtrl *m_previewCtrl = nullptr;
    Q_PROPERTY(PreviewCtrl *previewCtrl READ previewCtrl WRITE setPreviewCtrl NOTIFY
                   previewCtrlChanged FINAL)

    NoteBookCtrl *m_noteBookCtrl = nullptr;
    Q_PROPERTY(NoteBookCtrl *noteBookCtrl READ noteBookCtrl WRITE setNoteBookCtrl NOTIFY
                   noteBookCtrlChanged FINAL)

    NewNotesCtrl *m_newNotesCtrl = nullptr;
    Q_PROPERTY(NewNotesCtrl *newNotesCtrl READ newNotesCtrl WRITE setNewNotesCtrl NOTIFY
                   newNotesCtrlChanged FINAL)

    ImportMenuCtrl *m_importMenuCtrl = nullptr;
    Q_PROPERTY(ImportMenuCtrl *importMenuCtrl READ importMenuCtrl WRITE setImportMenuCtrl NOTIFY
                   importMenuCtrlChanged FINAL)

    ExportMenuCtrl *m_exportMenuCtrl = nullptr;
    Q_PROPERTY(ExportMenuCtrl *exportMenuCtrl READ exportMenuCtrl WRITE setExportMenuCtrl NOTIFY
                   exportMenuCtrlChanged FINAL)

    NotebookListModel *m_noteBookmodel = nullptr;
    Q_PROPERTY(NotebookListModel *noteBookmodel READ noteBookmodel WRITE setNoteBookmodel NOTIFY
                   noteBookmodelChanged FINAL)

    SidebarCtrl *m_sidebarCtrl = nullptr;
    Q_PROPERTY(SidebarCtrl *sidebarCtrl READ sidebarCtrl WRITE setSidebarCtrl NOTIFY
                   sidebarCtrlChanged FINAL)

    TopbarCtrl *m_topbarCtrl = nullptr;
    Q_PROPERTY(
        TopbarCtrl *topbarCtrl READ topbarCtrl WRITE setTopbarCtrl NOTIFY topbarCtrlChanged FINAL)
};
