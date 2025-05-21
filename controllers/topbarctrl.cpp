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

    html.replace(QRegularExpression(R"(^###### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h6>\1</h6>)");
    html.replace(QRegularExpression(R"(^##### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h5>\1</h5>)");
    html.replace(QRegularExpression(R"(^#### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h4>\1</h4>)");
    html.replace(QRegularExpression(R"(^### (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h3>\1</h3>)");
    html.replace(QRegularExpression(R"(^## (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h2>\1</h2>)");
    html.replace(QRegularExpression(R"(^# (.+)$)", QRegularExpression::MultilineOption),
                 R"(<h1>\1</h1>)");
}
