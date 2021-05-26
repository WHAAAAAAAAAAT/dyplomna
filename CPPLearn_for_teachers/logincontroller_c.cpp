#include "logincontroller_c.h"
#include "teacherinfomodel_c.h"
#include "jsontypes.h"
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
        TeacherInfoModel_c::instance()->setUsername(_username);
        TeacherInfoModel_c::instance()->setPassword(_password);
    }
    else
    {
        emit loginFail();
    }
}

void LoginController_c::registration(const QString &_name, const QString &_surname,
                                     const QString &_username, const QString &_password)
{
    auto json = createRegistrationJson(_name, _surname, _username, _password);
    if(NetworkModel_c::instance()->sendJson(json))
    {
        TeacherInfoModel_c::instance()->setUsername(_username);
        TeacherInfoModel_c::instance()->setPassword(_password);
        TeacherInfoModel_c::instance()->setName(_name);
        TeacherInfoModel_c::instance()->setSurname(_surname);
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
        {jsonKeys::title, jsonValues::login_teacher},
        {jsonKeys::username, _username},
        {jsonKeys::password, _password}
    };
}

QJsonObject LoginController_c::createRegistrationJson(const QString &_name, const QString &_surname, const QString &_username, const QString &_password)
{
    return QJsonObject
    {
        {jsonKeys::title, jsonValues::registration_teacher},
        {jsonKeys::username, _username},
        {jsonKeys::password, _password},
        {jsonKeys::name, _name},
        {jsonKeys::surname, _surname}
    };
}
