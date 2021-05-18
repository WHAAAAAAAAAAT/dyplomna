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

QJsonObject JsonConverter::fromCourseToJson(const QString &_courseName)
{
    return QJsonObject
    {
        {jsonKeys::title, jsonValues::course},
        {jsonKeys::courseName, _courseName}
    };
}

QJsonObject JsonConverter::fromTestToJson(const QString &_courseName, const QString &_lectureName, const QVector<TestListItem> &_test)
{
    QJsonObject jsonObj;
    jsonObj[jsonKeys::title] = jsonValues::test;
    jsonObj["LectureName"] = _lectureName;
    jsonObj["CourseName"] = _courseName;

    QJsonObject jsonTestQuestions;
    for(int i{0}; i < _test.size(); ++i)
    {
        QJsonObject tempObj;
        tempObj["Check"] = _test.at(i).check;
        tempObj["Question"] = _test.at(i).question;
        tempObj["CorrectAnswer"] = _test.at(i).correctAnswer;
        tempObj["Link"] = _test.at(i).linkToText;

        QJsonArray tempAnswers;
        qDebug() << "answers array: " << _test.at(i).answers;
        for(int j{0}; j < _test.at(i).answers.size(); ++j)
        {
            tempAnswers.append(_test.at(i).answers.at(j));
        }
        tempObj["Answers"] = tempAnswers;
        jsonTestQuestions["Task" + QString::number(i)] = tempObj;
    }
    jsonObj["Test"] = jsonTestQuestions;
    return jsonObj;
}

QJsonObject JsonConverter::fromLoadCourseToJson()
{
    return QJsonObject
    {
        {jsonKeys::title, jsonValues::loadCourses}
    };
}

QJsonObject JsonConverter::fromLoadLectureToJson(const QString &_courseName)
{
    return QJsonObject
    {
        {jsonKeys::title, jsonValues::loadLectures},
        {jsonKeys::courseName, _courseName}
    };
}
