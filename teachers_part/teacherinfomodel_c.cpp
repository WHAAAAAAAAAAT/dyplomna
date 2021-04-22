#include "teacherinfomodel_c.h"

#include <QDebug>

TeacherInfoModel_c* TeacherInfoModel_c::mInstance_ptr = nullptr;

void TeacherInfoModel_c::setUsername(const QString &_username)
{
    qDebug() << _username;
    if ((mUsername != _username) && !_username.isEmpty())
    {
        mUsername = _username;
        emit usernameChanged();
    }
}

void TeacherInfoModel_c::setPassword(const QString &_password)
{
    if ((mPassword != _password) && !_password.isEmpty())
    {
        mPassword = _password;
        emit passwordChanged();
    }
}

void TeacherInfoModel_c::setName(const QString &_name)
{
    if ((mName != _name) && !_name.isEmpty())
    {
        mName = _name;
        emit nameChanged();
    }
}

void TeacherInfoModel_c::setSurname(const QString &_surname)
{
    if ((mSurname != _surname) && !_surname.isEmpty())
    {
        mSurname = _surname;
        emit surnameChanged();
    }
}

QString TeacherInfoModel_c::username() const
{
    return mUsername;
}

QString TeacherInfoModel_c::password() const
{
    return mPassword;
}

QString TeacherInfoModel_c::name() const
{
    return mName;
}

QString TeacherInfoModel_c::surname() const
{
    return mSurname;
}

TeacherInfoModel_c::TeacherInfoModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}


TeacherInfoModel_c *TeacherInfoModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new TeacherInfoModel_c;
    }
    return mInstance_ptr;
}

QObject *TeacherInfoModel_c::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return TeacherInfoModel_c::instance();
}
