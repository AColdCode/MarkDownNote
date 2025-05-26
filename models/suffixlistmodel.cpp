#include "suffixlistmodel.h"

SuffixListModel::SuffixListModel(QObject *parent) : QAbstractListModel(parent) {}

int SuffixListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_items.size();
}

QVariant SuffixListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant("");

    SuffixItem *item = m_items.at(index.row());
    switch (role) {
    case SuffixRole:
        return item->suffix();
    case CheckedRole:
        return item->checked();
    default:
        return QVariant("");
    }
}

bool SuffixListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid() || index.row() >= m_items.size())
        return false;

    SuffixItem *item = m_items.at(index.row());
    if (role == CheckedRole) {
        item->setChecked(value.toBool());
        emit dataChanged(index, index, {CheckedRole});
        return true;
    }
    return false;
}

QHash<int, QByteArray> SuffixListModel::roleNames() const
{
    return {{SuffixRole, "suffix"}, {CheckedRole, "checked"}};
}

void SuffixListModel::addSuffix(const QString &suffix)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    auto *item = new SuffixItem(this);
    item->setSuffix(suffix);
    m_items.append(item);
    endInsertRows();
}

void SuffixListModel::clear()
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    endResetModel();
}

bool SuffixListModel::setChecked(int row, bool checked)
{
    if (row < 0 || row >= rowCount())
        return false;

    if (m_items.at(row)->checked() == checked)
        return true;
    QModelIndex idx = index(row, 0);
    return setData(idx, checked, CheckedRole);
}
