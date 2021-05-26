#pragma once

#include <QObject>
#include <QString>

#include "commondata.h"
#include "courseitem.h"

class CourseFolderModel_c : public QObject
{
    Q_OBJECT
public:
    static  CourseFolderModel_c* instance();

    void saveCourse(const CourseItem &_course);
    QJsonObject getCourses();
    QStringList getLecturesNames(const QString &_course);

private:
    explicit  CourseFolderModel_c(QObject *_parent_ptr = nullptr);

private:
    static  CourseFolderModel_c* mInstance_ptr;
};
