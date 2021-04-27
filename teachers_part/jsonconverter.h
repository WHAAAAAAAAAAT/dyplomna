#ifndef JSONCONVERTER_H
#define JSONCONVERTER_H

#include <QJsonObject>

#include "commondata.h"

class JsonConverter
{
public:
    JsonConverter();
    static QJsonObject fromLectureToJson(const QString &_lectureText, const int &_lectureNumber, const QString &_courseName);
};

#endif // JSONCONVERTER_H
