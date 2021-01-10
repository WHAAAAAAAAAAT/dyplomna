#include "usermodel.h"

UserModel::UserModel()
{
    mUsername = "";
    mPassword = "";
    mGroup = "";
}

QString UserModel::getUsername()
{
    return mUsername;
}

QString UserModel::getPassword()
{
    return mPassword;
}

QString UserModel::getGroup()
{
    return mGroup;
}

void UserModel::setUsername(const QString &username)
{
    mUsername = username;
}

void UserModel::setPassword(const QString &password)
{
    mPassword = password;
}

void UserModel::setGroup(const QString &group)
{
    mGroup = group;
}
