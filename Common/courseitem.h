#pragma once

#include <QString>
#include <QStringList>

struct CourseItem
{
    QString course;
    QStringList lectures;
    bool isVisible;
};
