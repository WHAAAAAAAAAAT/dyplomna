#include "logincontroller_c.h"
#include "jsontypes.h"
#include "userinfomodel_c.h"
#include "networkmodel_c.h"
#include "notificationmodel_c.h"

LoginController_c::LoginController_c(QObject *parent) : QObject(parent)
{
    connect(NotificationModel_c::instance(), &NotificationModel_c::loginSuccess, this, &LoginController_c::onLoginSuccess);
    connect(NotificationModel_c::instance(), &NotificationModel_c::loginFail, this, &LoginController_c::onLoginFail);
    connect(NotificationModel_c::instance(), &NotificationModel_c::registrationSuccess, this, &LoginController_c::onRegistrationSuccess);
    connect(NotificationModel_c::instance(), &NotificationModel_c::registrationFail, this, &LoginController_c::onRegistrationFail);
}

void LoginController_c::login(const QString &_username, const QString &_password)
{
    auto json = createLoginJson(_username, _password);
    if(NetworkModel_c::instance()->sendJson(json))
    {
        qDebug() << "login send";
        Student student;
        student.username = _username;
        UserInfoModel_c::instance()->getUserInfo(student);
        UserInfoModel_c::instance()->setUsername(_username);
        UserInfoModel_c::instance()->setPassword(_password);
        UserInfoModel_c::instance()->setName(student.name);
        UserInfoModel_c::instance()->setSurname(student.surname);
        UserInfoModel_c::instance()->setGroup(student.group);
    }
    else
    {
        emit loginFail();
    }
}

void LoginController_c::registration(const QString &_name, const QString &_surname,
                                     const QString &_group, const QString &_username,
                                     const QString &_password)
{
    auto json = createRegistrationJson(_name, _surname, _group, _username, _password);
    if(NetworkModel_c::instance()->sendJson(json))
    {
        qDebug() << "registration send";
        UserInfoModel_c::instance()->setUsername(_username);
        UserInfoModel_c::instance()->setPassword(_password);
        UserInfoModel_c::instance()->setName(_name);
        UserInfoModel_c::instance()->setSurname(_surname);
        UserInfoModel_c::instance()->setGroup(_group);
    }
    else
    {
        emit registrationFail();
    }
}

void LoginController_c::onLoginSuccess()
{
    emit loginSuccess();
}

void LoginController_c::onLoginFail()
{
    emit loginFail();
}

void LoginController_c::onRegistrationSuccess()
{
    emit registrationSuccess();
}

void LoginController_c::onRegistrationFail()
{
    emit registrationFail();
}

QJsonObject LoginController_c::createLoginJson(const QString &_username, const QString &_password)
{
    return QJsonObject
    {
        {jsonKeys::title, jsonValues::login_student},
        {jsonKeys::username, _username},
        {jsonKeys::password, _password}
    };
}

QJsonObject LoginController_c::createRegistrationJson(const QString &_name, const QString &_surname, const QString &_group,
                                                      const QString &_username, const QString &_password)
{
    return QJsonObject
    {
        {jsonKeys::title, jsonValues::registration_student},
        {jsonKeys::username, _username},
        {jsonKeys::password, _password},
        {jsonKeys::name, _name},
        {jsonKeys::surname, _surname},
        {jsonKeys::group, _group}
    };
}

