#include "jsonconverter.h"

#include "jsontypes.h"

JsonConverter::JsonConverter()
{

}

QJsonObject JsonConverter::fromLectureToJson(const QString &_lectureText, const QString &_lectureName, const QString &_courseName)
{
    return QJsonObject
    {
        {jsonKeys::title, jsonValues::lecture},
        {jsonKeys::text, _lectureText},
        {jsonKeys::lectureName, _lectureName},
        {jsonKeys::courseName, _courseName}
    };
}
