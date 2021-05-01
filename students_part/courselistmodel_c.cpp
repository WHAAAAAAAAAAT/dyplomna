#include "courselistmodel_c.h"

CourseListModel_c* CourseListModel_c::mInstance_ptr = nullptr;

CourseListModel_c::CourseListModel_c(QObject *parent) : QAbstractListModel(parent)
{
    mItems.append({QStringLiteral("C++"), QStringLiteral("Введення в С++"), false});
    mItems.append({QStringLiteral("C++"), QStringLiteral("Встановлення IDE"), false});
    //    mItems.append({QStringLiteral("C++"), QStringLiteral("lec3"), false});
    //    mItems.append({QStringLiteral("C++"), QStringLiteral("test1"), false});
    //    mItems.append({QStringLiteral("Java"), QStringLiteral("lec4"), false});
    //    mItems.append({QStringLiteral("Java"), QStringLiteral("lec5"), false});
    //    mItems.append({QStringLiteral("Java"), QStringLiteral("lec6"), false});
}

int CourseListModel_c::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return mItems.size();
}

QVariant CourseListModel_c::data(const QModelIndex &indexM, int role) const
{
    if (!indexM.isValid())
        return QVariant();

    const CourseItem item = mItems.at(indexM.row());
    switch (role) {
    case NameRole:
        return QVariant(item.name);
    case CourseRole:
        return QVariant(item.course);
    case VisibleRole:
        return QVariant(item.isVisible);
    }
    return QVariant();
}

#include <QDebug>

bool CourseListModel_c::setData(const QModelIndex &indexM, const QVariant &value, int role)
{
    auto item = mItems.at(indexM.row());
    switch (role) {
    case VisibleRole:
        item.isVisible = value.toBool();
        break;
    case CourseRole:
        item.course = value.toString();
        break;
    case NameRole:
        item.name = value.toString();
        break;
    }

    if (indexM.row() < 0 || indexM.row() >= mItems.size())
        return false;

    mItems[indexM.row()] = item;
    emit dataChanged(indexM, indexM, QVector<int>() << role);
    return true;
}

QHash<int, QByteArray> CourseListModel_c::roleNames() const
{
    QHash<int, QByteArray> names;
    names[VisibleRole] = "aVisible";
    names[CourseRole] = "type";
    names[NameRole] = "name";
    return names;
}

QObject *CourseListModel_c::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return CourseListModel_c::instance();
}

CourseListModel_c *CourseListModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new CourseListModel_c;
    }
    return mInstance_ptr;
}

void CourseListModel_c::updateVisibleForCourse(const QString &_course)
{
    for (auto &i : mItems)
    {
        i.isVisible = i.course == _course;
    }
    emit dataChanged(index(0,0), index(mItems.size() - 1, 0));
}

void CourseListModel_c::addLecture(const QString _lectureName)
{
    qDebug () << _lectureName;
    mItems.append({QStringLiteral("C++"), _lectureName, true});
    emit dataChanged(index(0,0), index(mItems.size() - 1, 0));
}
