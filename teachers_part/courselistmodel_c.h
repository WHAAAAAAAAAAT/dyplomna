#pragma once

#include <QObject>
#include <QAbstractListModel>

#include "courseitem.h"

class CourseListModel_c : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit CourseListModel_c(QObject *parent = nullptr);

    enum {
        CourseRole,
        NameRole,
        VisibleRole,
    };

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void updateVisibleForCourse(const QString &_course);

private:
    QVector<CourseItem> mItems;
};
