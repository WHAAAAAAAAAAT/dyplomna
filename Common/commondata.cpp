#include "commondata.h"

User Network::jsonToUser(const QJsonObject &_json)
{
    return {_json.value(jsonKeys::username).toString(), _json.value(jsonKeys::password).toString(),
            _json.value(jsonKeys::name).toString(), _json.value(jsonKeys::surname).toString()};
}

Student Network::jsonToStudent(const QJsonObject &_json)
{
    return {{_json.value(jsonKeys::username).toString(), _json.value(jsonKeys::password).toString(),
            _json.value(jsonKeys::name).toString(), _json.value(jsonKeys::surname).toString()}, _json.value(jsonKeys::group).toString()};
}

Lecture Network::jsonToLecture(const QJsonObject &_json)
{
    return {_json.value(jsonKeys::text).toString(), _json.value(jsonKeys::lectureName).toString(), _json.value(jsonKeys::courseName).toString()};
}

CourseItem Network::jsonToCourse(const QJsonObject &_json)
{
    CourseItem newCourse;
    newCourse.course = _json.value(jsonKeys::courseName).toString();
    return newCourse;
}

Test Network::jsonToTest(const QJsonObject &_json)
{
    Test test;

    QJsonValue jsonVal;
    jsonVal = _json.value("LectureName");
    test.lectureName = jsonVal.toString();
    jsonVal = _json.value("CourseName");
    test.courseName = jsonVal.toString();

    QJsonObject jsonTestQuestions;
    jsonVal = _json.value(QString("Test"));
    jsonTestQuestions = jsonVal.toObject();

    for(int i{0}; i < jsonTestQuestions.size(); ++i)
    {
        TestListItem tempListItem;

        QJsonObject tempObj;
        jsonVal = jsonTestQuestions.value(QString("Task" + QString::number(i)));
        tempObj  = jsonVal.toObject();

        tempListItem.question = tempObj["Question"].toString();
        tempListItem.correctAnswer = tempObj["CorrectAnswer"].toString();
        tempListItem.linkToText = tempObj["Link"].toString();
        tempListItem.check = tempObj["Check"].toVariant().toBool();

        QJsonArray tempAnswers = tempObj["Answers"].toArray();
        for(int i{0}; i < tempAnswers.size(); ++i)
        {
            tempListItem.answers.append(tempAnswers.at(i).toString());
        }
        test.testList.append(tempListItem);
    }
    return test;
}

StudentAnswers Network::jsonToAnswers(const QJsonObject &_json)
{
    StudentAnswers answers;

    QJsonValue jsonVal;
    jsonVal = _json.value("LectureName");
    answers.lectureName = jsonVal.toString();
    jsonVal = _json.value("CourseName");
    answers.courseName = jsonVal.toString();
    jsonVal = _json.value("Username");
    answers.username = jsonVal.toString();

    QJsonObject jsonTestQuestions;
    jsonVal = _json.value(QString("Test"));
    jsonTestQuestions = jsonVal.toObject();

    for(int i{0}; i < jsonTestQuestions.size(); ++i)
    {
        AnswerItem tempListItem;

        QJsonObject tempObj;
        jsonVal = jsonTestQuestions.value(QString("Task" + QString::number(i)));
        tempObj  = jsonVal.toObject();

        tempListItem.question = tempObj["Question"].toString();
        tempListItem.answer = tempObj["Answer"].toString();
        answers.answerList.append(tempListItem);
    }
    return answers;
}
