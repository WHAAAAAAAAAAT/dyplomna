#include "courselistmodel_c.h"
#include <QDebug>
#include "networkmodel_c.h"
#include "notificationmodel_c.h"
#include "jsonconverter.h"

CourseListModel_c* CourseListModel_c::mInstance_ptr = nullptr;

CourseListModel_c::CourseListModel_c(QObject *parent) : QAbstractListModel(parent)
{
    if(NetworkModel_c::instance()->sendJson(JsonConverter::fromLoadCourseToJson()))
        qDebug() << "load courses send";
}

int CourseListModel_c::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mItems.size();
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
    default:
        return QVariant();
    }
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

void CourseListModel_c::loadLectures(QString _courseName, QString lectureName)
{
    int courseIndex{0};
    for(int i{0}; i < mItems.size(); ++i)
    {
        if(mItems.at(i).course == _courseName)
        {
            courseIndex = i;
            break;
        }
    }
    QString lectureText;
    for(int i{0}; i < mLectures.at(courseIndex).size(); ++i)
    {
        if(mLectures.at(courseIndex).at(i).name == lectureName)
        {
            lectureText = mLectures.at(courseIndex).at(i).text;
            break;
        }
    }
    emit lectureRecived(lectureText);
}

void CourseListModel_c::setCourses(QVector<CourseItem> _courses)
{
    beginResetModel();
    mItems = _courses;
    endResetModel();

    for(int i{0}; i < mItems.size(); ++i)
    {
        NetworkModel_c::instance()->sendJson(JsonConverter::fromLoadLectureToJson(mItems.at(i).course));
    }
    emit dataChanged(index(0,0), index(mItems.size() - 1, 0));
}

void CourseListModel_c::setLectures(QVector<Lecture> _lectures)
{
    mLectures.append(_lectures);
    emit dataChanged(index(0,0), index(mItems.size() - 1, 0));
}

QStringList CourseListModel_c::lecturesList(int index)
{
    return mItems.at(index).lectures;
}

void CourseListModel_c::addLecture(const QString _lectureName, const QString _courseName)
{
    int index{0};
    for (int i{0}; i < mItems.size(); ++i)
    {
        if(mItems[i].course == _courseName)
        {
            index = i;
            break;
        }
    }
    beginResetModel();
    mItems[index].lectures.append(_lectureName);
    endResetModel();
}

void CourseListModel_c::addCourse(const QString &_course)
{
    for(auto item : mItems)
    {
        if(item.course == _course)
        {
            qDebug() << "course is already created";
            return;
        }
    }
    QJsonObject courseJson = JsonConverter::fromCourseToJson(_course);
    if(NetworkModel_c::instance()->sendJson(courseJson))
    {
        qDebug() << "course name send";
        const int index = mItems.size();
        beginInsertRows(QModelIndex(), index, index);
        mItems.append({_course, QStringList{""}, false});
        endInsertRows();
    }
    else
    {
        qDebug() << "course name not send";
    }
}

void CourseListModel_c::removeCourse(const QString &_course)
{
    for (int i{0}; i < mItems.size(); ++i)
    {
        if (mItems[i].course == _course) {
            beginRemoveRows(QModelIndex(), i, i);
            mItems.removeAt(i);
            endRemoveRows();
        }
    }
}

void CourseListModel_c::saveCurrentLecture(QQuickTextDocument *_lecture, const QString &_lectureName, const QString &_courseName)
{
    int courseIndex{0};
    for(int i{0}; i < mItems.size(); ++i)
    {
        if(mItems.at(i).course == _courseName)
        {
            courseIndex = i;
            break;
        }
    }
    QString lectureText;
    for(int i{0}; i < mLectures.at(courseIndex).size(); ++i)
    {
        if(mLectures.at(courseIndex).at(i).name == _lectureName)
        {
            mLectures[courseIndex][i].text = _lecture->textDocument()->toHtml();
            break;
        }
    }

    emit dataChanged(index(0,0), index(mItems.size() - 1, 0), {Qt::EditRole});
}
