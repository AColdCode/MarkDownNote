// editorentry.h
#pragma once
#include <QString>

class EditorEntry
{
public:
    QString fileName;
    QString filePath;
    QString content;

    EditorEntry(const QString &name = "", const QString &path = "", const QString &content = "");
};
