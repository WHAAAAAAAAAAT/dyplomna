#include "courselistmodel_c.h"
#include <QDebug>

CourseListModel_c* CourseListModel_c::mInstance_ptr = nullptr;

CourseListModel_c::CourseListModel_c(QObject *parent) : QAbstractListModel(parent)
{
    QStringList newList = {"Введення в С++", "Встановлення IDE"};
    QStringList newList2 = {"Мова програмування\nJava"};
    mItems.append({QStringLiteral("C++"), newList, false});
    mItems.append({QStringLiteral("Java"), newList2, false});
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
    case LecturesRole:
        return QVariant(item.lectures);
    case CourseRole:
        return QVariant(item.course);
    case VisibleRole:
        return QVariant(item.isVisible);
    }
    return QVariant();
}

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
    case LecturesRole:
        item.lectures = value.toStringList();
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
    names[CourseRole] = "course";
    names[LecturesRole] = "lecturesList";
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

QStringList CourseListModel_c::lecturesList(int index)
{
    return mItems.at(index).lectures;
}

void CourseListModel_c::addLecture(const QString _lectureName, const QString _courseName)
{
    for (auto item : mItems)
    {
        if(item.course == _courseName)
        {
            item.lectures.append(_lectureName);
            break;
        }
    }
    emit dataChanged(index(0,0), index(mItems.size() - 1, 0));
}
