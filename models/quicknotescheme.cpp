#include "quicknotescheme.h"

QuickNoteScheme::QuickNoteScheme(QObject *parent) : QObject(parent) {}

QuickNoteScheme::QuickNoteScheme(const QString &folderPath,
                                 const QString &name,
                                 const QString &pattern,
                                 QObject *parent)
    : QObject(parent)
    , m_folderPath(folderPath)
    , m_name(name)
    , m_noteName(pattern)
{}

QString QuickNoteScheme::folderPath() const
{
    return m_folderPath;
}

void QuickNoteScheme::setFolderPath(const QString &newFolderPath)
{
    if (m_folderPath == newFolderPath)
        return;
    m_folderPath = newFolderPath;
    emit folderPathChanged();
}

QString QuickNoteScheme::name() const
{
    return m_name;
}

void QuickNoteScheme::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}

QString QuickNoteScheme::noteName() const
{
    return m_noteName;
}

void QuickNoteScheme::setNoteName(const QString &newNoteName)
{
    if (m_noteName == newNoteName)
        return;
    m_noteName = newNoteName;
    emit noteNameChanged();
}
