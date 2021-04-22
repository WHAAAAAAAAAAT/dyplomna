#include "userinfomodel_c.h"

#include <QDebug>

UserInfoModel_c* UserInfoModel_c::mInstance_ptr = nullptr;

void UserInfoModel_c::setUsername(const QString &_username)
{
    qDebug() << "setUsername" << _username;
    if ((mUsername != _username) && !_username.isEmpty())
    {
        mUsername = _username;
        emit usernameChanged();
    }
}

void UserInfoModel_c::setPassword(const QString &_password)
{
    if ((mPassword != _password) && !_password.isEmpty())
    {
        mPassword = _password;
        emit passwordChanged();
    }
}

void UserInfoModel_c::setName(const QString &_name)
{
    if ((mName != _name) && !_name.isEmpty())
    {
        mName = _name;
        emit nameChanged();
    }
}

void UserInfoModel_c::setSurname(const QString &_surname)
{
    if ((mSurname != _surname) && !_surname.isEmpty())
    {
        mSurname = _surname;
        emit surnameChanged();
    }
}

void UserInfoModel_c::setGroup(const QString &_group)
{
    if ((mGroup != _group) && !_group.isEmpty())
    {
        mGroup = _group;
        emit groupChanged();
    }
}

QString UserInfoModel_c::username() const
{
    return mUsername;
}

QString UserInfoModel_c::password() const
{
    return mPassword;
}

QString UserInfoModel_c::name() const
{
    return mName;
}

QString UserInfoModel_c::surname() const
{
    return mSurname;
}

QString UserInfoModel_c::group() const
{
    return mGroup;
}

UserInfoModel_c::UserInfoModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}


UserInfoModel_c *UserInfoModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new UserInfoModel_c;
    }
    return mInstance_ptr;
}

QObject *UserInfoModel_c::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return UserInfoModel_c::instance();
}
