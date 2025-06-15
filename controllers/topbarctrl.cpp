#include "topbarctrl.h"
#include <QRegularExpression>

TopbarCtrl::TopbarCtrl(QObject *parent)
    : QObject{parent}
{}

QObject *TopbarCtrl::textArea() const
{
    return m_textArea;
}

void TopbarCtrl::setTextArea(QObject *newTextArea)
{
    if (m_textArea == newTextArea)
        return;
    m_textArea = newTextArea;
    emit textAreaChanged();
}

void TopbarCtrl::onBoldClicked()
{
    if (!m_textArea)
        return;
    int position = m_textArea->property("cursorPosition").toInt();
    int end = m_textArea->property("oldselection_End").toInt();
    int start = m_textArea->property("oldselection_Start").toInt();
    qDebug() << end;
    qDebug() << start;

    //QMetaObject::invokeMethod(m_textArea, "insert", Q_ARG(int, position), Q_ARG(QString, "****"));
    QMetaObject::invokeMethod(m_textArea, "insert", Q_ARG(int, start), Q_ARG(QString, "**"));
    QMetaObject::invokeMethod(m_textArea, "insert", Q_ARG(int, end + 2), Q_ARG(QString, "**"));
}

void TopbarCtrl::menuItemSelected(int type)
{
    if (!m_textArea)
        return;

    QVariant pos;
    QMetaObject::invokeMethod(m_textArea, "getCurrentLineStart", Q_RETURN_ARG(QVariant, pos));
    int position = pos.toInt();

    switch (type) {
    case 1:
        QMetaObject::invokeMethod(m_textArea, "insert", Q_ARG(int, position), Q_ARG(QString, "# "));
        oldtype = type;
        oldposition = position;
        break;
    case 2:
        QMetaObject::invokeMethod(m_textArea, "insert", Q_ARG(int, position), Q_ARG(QString, "## "));
        oldtype = type;
        oldposition = position;
        break;
    case 3:
        QMetaObject::invokeMethod(m_textArea,
                                  "insert",
                                  Q_ARG(int, position),
                                  Q_ARG(QString, "### "));
        oldtype = type;
        oldposition = position;
        break;
    case 4:
        QMetaObject::invokeMethod(m_textArea,
                                  "insert",
                                  Q_ARG(int, position),
                                  Q_ARG(QString, "#### "));
        oldtype = type;
        oldposition = position;
        break;
    case 5:
        QMetaObject::invokeMethod(m_textArea,
                                  "insert",
                                  Q_ARG(int, position),
                                  Q_ARG(QString, "##### "));
        oldtype = type;
        oldposition = position;
        break;
    case 6:
        QMetaObject::invokeMethod(m_textArea,
                                  "insert",
                                  Q_ARG(int, position),
                                  Q_ARG(QString, "###### "));
        oldtype = type;
        oldposition = position;
        break;
    case 7:
        if (oldtype == 0) {
            break;
        }

        // 调用 QML 的 remove 方法：remove(start, count)
        QMetaObject::invokeMethod(m_textArea,
                                  "remove",
                                  Q_ARG(int, oldposition),
                                  Q_ARG(int, oldposition + oldtype + 1));

        oldtype = 0;
        break;
    }
}

void TopbarCtrl::insertText(const QString &content)
{
    if (!m_textArea)
        return;
    int position = m_textArea->property("cursorPosition").toInt();

    // 方法1：直接调用QML方法（需QML对象有insert方法）
    QMetaObject::invokeMethod(m_textArea, "insert", Q_ARG(int, position), Q_ARG(QString, content));
}
