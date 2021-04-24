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

class LoginVerificationModel_c : QObject
{

public:
    static LoginVerificationModel_c *instance();
    QJsonDocument loadJson(const QString &fileName);
    void saveJson(const QJsonDocument &document, const QString &fileName);

    bool verifyLoginTeacher(const QString &_username, const QString &_password);
    bool verifyRegistrationTeacher(const QString &_username, const QString &_password,
                                   const QString &_name, const QString &_surname);

    bool verifyLoginStudent(const QString &_username, const QString &_password);
    bool verifyRegistrationStudent(const QString &_username, const QString &_password,
                                   const QString &_name, const QString &_surname, const QString &_group);

private:
    explicit LoginVerificationModel_c(QObject *_parent_ptr = nullptr);
    static LoginVerificationModel_c *mInstance_ptr;
    const QString teacherJsonFileName{"teachersinfo.json"};
    const QString studentJsonFileName{"studentsinfo.json"};

    bool loginHelper(const QString &_username, const QString &_password, const QJsonDocument & _doc);
    QJsonObject createNewUser(const QString &_username, const QString &_password,
                              const QString &_name, const QString &_surname);

    QJsonObject createNewStudent(const QString &_username, const QString &_password,
                                   const QString &_name, const QString &_surname, const QString &_group);
};

#endif // LOGINVERIFICATIONMODEL_C_H
