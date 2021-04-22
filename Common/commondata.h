#pragma once

#include <QString>
#include <QTextDocument>
#include <QJsonObject>

#include "jsontypes.h"

struct User {
    QString username;
    QString password;
    QString name;
    QString surname;
    QString group;
};

struct Lecture {
    QTextDocument lectureText;
};

namespace Network {
    static const quint16 port = 1234;
    static const QString mIp = QStringLiteral("wss://localhost");

    User jsonToUser(const QJsonObject &_json);
    Lecture jsonToLecture(const QJsonObject &_json);
}
