#pragma once

#include <QObject>
#include <QJsonArray>
#include <QString>

namespace jsonKeys {
    static const QString title = "title";
    static const QString username = "username";
    static const QString password = "password";
    static const QString name = "name";
    static const QString surname = "surname";
    static const QString group = "group";

    static const QString text = "text";
    static const QString lectureName = "lectureName";
    static const QString courseName = "courseName";

    static const QJsonArray testArray;
}

namespace jsonValues {
    static const QString registration_student = "registration_student";
    static const QString registration_teacher = "registration_teacher";

    static const QString login_student = "login_student";
    static const QString login_teacher = "login_teacher";

    static const QString lecture = "lectureToServer";
    static const QString course = "courseToServer";
    static const QString test = "testToServer";
    static const QString answers = "answersToServer";
    static const QString loadCourses = "loadCourses";
    static const QString loadLectures = "loadLectures";
    static const QString loadTests = "loadTests";
}
