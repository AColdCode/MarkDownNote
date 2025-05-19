#include "markdownctrl.h"
#include "controllers/editorctrl.h"
#include "controllers/expandctrl.h"
#include "controllers/menuctrl.h"
#include "controllers/previewctrl.h"

MarkDownCtrl::MarkDownCtrl(QObject *parent)
    : QObject{parent}
    , m_editorCtrl{new EditorCtrl(this)}
    , m_expandCtrl{new ExpandCtrl(this)}
    , m_menuCtrl{new MenuCtrl(this)}
    , m_previewCtrl{new PreviewCtrl(this)}
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
