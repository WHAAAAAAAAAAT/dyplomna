#pragma once

#include <QString>
#include <QJsonObject>

#include "jsontypes.h"
#include "user.h"
struct Lecture {
    QString lectureText;
};

namespace Network {
    static const quint16 port = 1234;
    static const QString mIp = QStringLiteral("wss://localhost");

    User jsonToUser(const QJsonObject &_json);
    Lecture jsonToLecture(const QJsonObject &_json);
}
