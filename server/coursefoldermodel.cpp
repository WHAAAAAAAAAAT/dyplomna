#include "coursefoldermodel.h"

#include <QDebug>
#include <QFile>
#include <QDir>
#include <QStandardPaths>


CourseFolderModel_c* CourseFolderModel_c::mInstance_ptr = nullptr;

CourseFolderModel_c::CourseFolderModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}

CourseFolderModel_c *CourseFolderModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new CourseFolderModel_c;
    }
    return mInstance_ptr;
}

void CourseFolderModel_c::saveCourse(const CourseItem &_course)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/");
    bool pathExists = directory.cd(_course.course);
    if(!pathExists)
    {
        directory.mkdir(_course.course);
    }
    qDebug() << "course created on server";
}

QJsonObject CourseFolderModel_c::getCourses()
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/");
    QStringList courseNames = directory.entryList(QDir::AllDirs | QDir::NoDotAndDotDot);
    qDebug() << "courses list: " << courseNames;
    QJsonObject tempObj;
    tempObj[jsonKeys::title] = "Courses";
    for(int i{0}; i < courseNames.size(); ++i)
    {
        tempObj["Course " + QString::number(i)] = courseNames.at(i);
        QJsonArray tempArray;
        QStringList lectures = getLecturesNames(courseNames.at(i));
        for(int j{0}; j < lectures.size(); ++j)
        {
            tempArray.append(lectures.at(j));
        }
        tempObj["Lectures at course " + QString::number(i)] = tempArray;
    }
    qDebug() << "got courses";
    return tempObj;
}

QStringList CourseFolderModel_c::getLecturesNames(const QString &_course)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/" + _course + "/");
    QStringList lectures = directory.entryList(QDir::AllDirs | QDir::NoDotAndDotDot);
    return lectures;
}


