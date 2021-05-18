#include "userinfomodel_c.h"

#include <QDebug>

UserInfoModel_c* UserInfoModel_c::mInstance_ptr = nullptr;

void UserInfoModel_c::setUsername(const QString &_username)
{
    qDebug() << "setUsername" << _username;
    if ((mStudent.username != _username) && !_username.isEmpty())
    {
        mStudent.username = _username;
        emit usernameChanged();
    }
}

void UserInfoModel_c::setPassword(const QString &_password)
{
    if ((mStudent.password != _password) && !_password.isEmpty())
    {
        mStudent.password = _password;
        emit passwordChanged();
    }
}

void UserInfoModel_c::setName(const QString &_name)
{
    if ((mStudent.name != _name) && !_name.isEmpty())
    {
        mStudent.name = _name;
        emit nameChanged();
    }
}

void UserInfoModel_c::setSurname(const QString &_surname)
{
    if ((mStudent.surname != _surname) && !_surname.isEmpty())
    {
        mStudent.surname = _surname;
        emit surnameChanged();
    }
}

void UserInfoModel_c::setGroup(const QString &_group)
{
    if ((mStudent.group != _group) && !_group.isEmpty())
    {
        mStudent.group = _group;
        emit groupChanged();
    }
}

QString UserInfoModel_c::username() const
{
    return mStudent.username;
}

QString UserInfoModel_c::password() const
{
    return mStudent.password;
}

QString UserInfoModel_c::name() const
{
    return mStudent.name;
}

QString UserInfoModel_c::surname() const
{
    return mStudent.surname;
}

QString UserInfoModel_c::group() const
{
    return mStudent.group;
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

void UserInfoModel_c::getUserInfo(Student &_student)
{
    QJsonDocument _doc = loadJson(studentJsonFileName);
    if(_doc.isObject())
    {
        QJsonObject usersInfoObj = _doc.object();
        QJsonArray usersInfoArray = usersInfoObj["usersinfo"].toArray();
        foreach (const QJsonValue &currentUsersInfo, usersInfoArray)
        {
            QJsonObject currentUser = currentUsersInfo.toObject();
            if(_student.username == currentUser["username"].toString())
            {
                _student.name = currentUser["name"].toString();
                _student.surname = currentUser["surname"].toString();
                _student.group = currentUser["group"].toString();
                break;
            }
            else
            {
                continue;
            }
        }
    }
}

QJsonDocument UserInfoModel_c::loadJson(const QString &fileName)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents);
    bool pathExists = directory.cd("CPPLearn");
    if(!pathExists)
    {
        directory.mkdir("CPPLearn");
    }
    directory.setPath(documents + "/CPPLearn");
    QFile jsonFile(directory.filePath(fileName));
    jsonFile.open(QFile::ReadWrite);
    QJsonDocument tempDocument = QJsonDocument().fromJson(jsonFile.readAll());
    jsonFile.close();
    return tempDocument;
}

QObject *UserInfoModel_c::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return UserInfoModel_c::instance();
}
