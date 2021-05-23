#pragma once

#include <QString>
#include <QJsonObject>

#include "jsontypes.h"
#include "user.h"
#include "lecture.h"
#include "courseitem.h"
#include "testitem.h"
#include "answeritem.h"

namespace Network {
    static const quint16 port = 1234;
    static const QString mIp = QStringLiteral("wss://localhost");

    User jsonToUser(const QJsonObject &_json);
    Lecture jsonToLecture(const QJsonObject &_json);
    Student jsonToStudent(const QJsonObject &_json);
    CourseItem jsonToCourse(const QJsonObject &_json);
    Test jsonToTest(const QJsonObject &_json);
    StudentAnswers jsonToAnswers(const QJsonObject &_json);
}
