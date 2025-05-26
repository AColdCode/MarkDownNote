#include "suffixitem.h"

SuffixItem::SuffixItem(QObject *parent) : QObject(parent), m_checked(false) {}

QString SuffixItem::suffix() const
{
    return m_suffix;
}

void SuffixItem::setSuffix(const QString &s)
{
    if (s != m_suffix) {
        m_suffix = s;
        emit suffixChanged();
    }
}

bool SuffixItem::checked() const
{
    return m_checked;
}

void SuffixItem::setChecked(bool c)
{
    if (c != m_checked) {
        m_checked = c;
        emit checkedChanged();
    }
}
