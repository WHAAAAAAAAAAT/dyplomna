#include "teacherinfomodel_c.h"

#include <QDebug>

TeacherInfoModel_c* TeacherInfoModel_c::mInstance_ptr = nullptr;

void TeacherInfoModel_c::setUsername(const QString &_username)
{
    qDebug() << _username;
    if ((mTeacher.username != _username) && !_username.isEmpty())
    {
        mTeacher.username = _username;
        emit usernameChanged();
    }
}

void TeacherInfoModel_c::setPassword(const QString &_password)
{
    if ((mTeacher.password != _password) && !_password.isEmpty())
    {
        mTeacher.password = _password;
        emit passwordChanged();
    }
}

void TeacherInfoModel_c::setName(const QString &_name)
{
    if ((mTeacher.name != _name) && !_name.isEmpty())
    {
        mTeacher.name = _name;
        emit nameChanged();
    }
}

void TeacherInfoModel_c::setSurname(const QString &_surname)
{
    if ((mTeacher.surname != _surname) && !_surname.isEmpty())
    {
        mTeacher.surname = _surname;
        emit surnameChanged();
    }
}

QString TeacherInfoModel_c::username() const
{
    return mTeacher.username;
}

QString TeacherInfoModel_c::password() const
{
    return mTeacher.password;
}

QString TeacherInfoModel_c::name() const
{
    return mTeacher.name;
}

QString TeacherInfoModel_c::surname() const
{
    return mTeacher.surname;
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
