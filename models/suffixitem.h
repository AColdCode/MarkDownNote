// suffixitem.h
#pragma once
#include <QObject>

class SuffixItem : public QObject
{
    Q_OBJECT
public:
    explicit SuffixItem(QObject *parent = nullptr);

    QString suffix() const;
    void setSuffix(const QString &s);

    bool checked() const;
    void setChecked(bool c);

signals:
    void suffixChanged();
    void checkedChanged();

private:
    QString m_suffix;
    Q_PROPERTY(QString suffix READ suffix WRITE setSuffix NOTIFY suffixChanged)

    bool m_checked;
    Q_PROPERTY(bool checked READ checked WRITE setChecked NOTIFY checkedChanged)
};
