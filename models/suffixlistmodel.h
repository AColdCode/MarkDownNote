#pragma once
#include <QAbstractListModel>

#include "suffixitem.h"

class SuffixListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles { SuffixRole = Qt::UserRole + 1, CheckedRole };

    explicit SuffixListModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addSuffix(const QString &suffix);

    Q_INVOKABLE void clear();

    Q_INVOKABLE bool setChecked(int row, bool checked);

private:
    QList<SuffixItem *> m_items;
};
