#include "jsonconverter.h"

#include "jsontypes.h"

JsonConverter::JsonConverter()
{

}

QJsonObject JsonConverter::fromLectureToJson(const QString &_lectureText, const int &_lectureNumber, const QString &_courseName)
{
    return QJsonObject
    {
        {jsonKeys::title, jsonValues::lecture},
        {jsonKeys::text, _lectureText},
        {jsonKeys::number, _lectureNumber},
        {jsonKeys::courseName, _courseName}
    };
}
