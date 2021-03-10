#include "logincontroller_c.h"

#include "userinfomodel_c.h"

LoginController_c::LoginController_c(QObject *parent) : QObject(parent)
{}

void LoginController_c::login(const QString &_username, const QString &_password)
{
    UserInfoModel_c::instance()->setUsername(_username);
    UserInfoModel_c::instance()->setPassword(_password);
}

void LoginController_c::registration(const QString &_name, const QString &_surname, const QString &_group,
                                     const QString &_username, const QString &_password)
{
    UserInfoModel_c::instance()->setUsername(_username);
    UserInfoModel_c::instance()->setPassword(_password);
    UserInfoModel_c::instance()->setName(_name);
    UserInfoModel_c::instance()->setSurname(_surname);
    UserInfoModel_c::instance()->setGroup(_group);
}
