#pragma once

#include <QObject>
#include <QString>
#include <QTextDocument>

namespace jsonKeys {
    static const QString title = "title";
    static const QString username = "username";
    static const QString password = "password";
    static const QString name = "name";
    static const QString surname = "surname";
    static const QString group = "group";

    static const QString lectureName = "lectureName";
}

namespace jsonValues {
    static const QString registration = "registration";
    static const QString login = "login";

    static const QString lectureCreation = "lectureCreation";
}
