#ifndef JSONCONVERTER_H
#define JSONCONVERTER_H

#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>

#include "commondata.h"
//#include "testcreator/testlist.h"

class JsonConverter
{
public:
    JsonConverter();
    static QJsonObject fromLectureToJson(const QString &_lectureText, const QString &_lectureName, const QString &_courseName);
    static QJsonObject fromCourseToJson(const QString &_courseName);
    static QJsonObject fromTestToJson(const QString &_courseName, const QString &_lectureName, const QVector<TestListItem> &_test);
    static QJsonObject fromAnswersToJson(const QString &_courseName, const QString &_lectureName, const QVector<AnswerItem> &_test);
    static QJsonObject fromLoadCourseToJson();
    static QJsonObject fromLoadLectureToJson(const QString &_courseName);
    static QJsonObject fromLoadTestToJson(const QString &_courseName, const QString &_lectureName);
};

#endif // JSONCONVERTER_H
