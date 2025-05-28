#include "editorentry.h"

EditorEntry::EditorEntry(const QString &name, const QString &path, const QString &content)
    : fileName(name)
    , filePath(path)
    , content(content)
{}
