#pragma once

#include <QObject>
#include <QQmlEngine>

class ExpandCtrl;
class EditorCtrl;
class MenuCtrl;
class PreviewCtrl;

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

signals:
    void editorCtrlChanged();

    void expandCtrlChanged();

    void menuCtrlChanged();

    void previewCtrlChanged();

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
};
