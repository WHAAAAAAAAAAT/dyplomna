#ifndef LOGINVERIFICATIONMODEL_C_H
#define LOGINVERIFICATIONMODEL_C_H

#include <QObject>
#include <QString>
#include <QDir>
#include <QJsonDocument>
#include <QJsonArray>
#include <QFile>
#include <QJsonValue>
#include <QJsonObject>
#include <QStandardPaths>

#include "user.h"

class LoginVerificationModel_c : QObject
{

public:
    static LoginVerificationModel_c *instance();
    QJsonDocument loadJson(const QString &fileName);
    void saveJson(const QJsonDocument &document, const QString &fileName);

    bool verifyLoginTeacher(const User &_user);
    bool verifyRegistrationTeacher(const User &_user);

    bool verifyLoginStudent(const User &_user);
    bool verifyRegistrationStudent(const Student &_student);

private:
    explicit LoginVerificationModel_c(QObject *_parent_ptr = nullptr);
    static LoginVerificationModel_c *mInstance_ptr;
    const QString teacherJsonFileName{"teachersinfo.json"};
    const QString studentJsonFileName{"studentsinfo.json"};

    bool loginHelper(const QString &_username, const QString &_password, const QJsonDocument & _doc);
    QJsonObject createNewUser(const User & _user);

    QJsonObject createNewStudent(const Student&_student);
};

#endif // LOGINVERIFICATIONMODEL_C_H
