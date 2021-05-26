#include "loginverificationmodel_c.h"

#include <QDebug>
#include "jsontypes.h"

LoginVerificationModel_c *LoginVerificationModel_c::mInstance_ptr = nullptr;

LoginVerificationModel_c::LoginVerificationModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}

bool LoginVerificationModel_c::loginHelper(const QString &_username, const QString &_password, const QJsonDocument &_doc)
{
    if(_doc.isObject())
    {
        QJsonObject usersInfoObj = _doc.object();
        QJsonArray usersInfoArray = usersInfoObj["usersinfo"].toArray();
        foreach (const QJsonValue &currentUsersInfo, usersInfoArray)
        {
            QJsonObject currentUser = currentUsersInfo.toObject();
            if(_username == currentUser["username"].toString())
            {
                return (_password == currentUser["password"].toString());
            }
            else
            {
                continue;
            }
        }
    }
    else
    {
        return false;
    }
    return false;
}

QJsonObject LoginVerificationModel_c::createNewUser(const User &_user)
{
    QJsonObject newUser;
    newUser.insert(jsonKeys::username, QJsonValue::fromVariant(_user.username));
    newUser.insert(jsonKeys::name, QJsonValue::fromVariant(_user.name));
    newUser.insert(jsonKeys::surname, QJsonValue::fromVariant(_user.surname));
    newUser.insert(jsonKeys::password, QJsonValue::fromVariant(_user.password));
    return newUser;
}


QJsonObject LoginVerificationModel_c::createNewStudent(const Student &_student)
{
    QJsonObject student = createNewUser(_student);
    student.insert(jsonKeys::group, QJsonValue::fromVariant(_student.group));
    qDebug() << "newUserInfo :" << student;
    return student;
}

QJsonDocument LoginVerificationModel_c::loadJson(const QString &fileName)
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

void LoginVerificationModel_c::saveJson(const QJsonDocument &document, const QString &fileName)
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
    jsonFile.open(QFile::WriteOnly);
    jsonFile.write(document.toJson());
    jsonFile.close();
}

bool LoginVerificationModel_c::verifyLoginTeacher(const User &_user)
{
    return loginHelper(_user.username, _user.password, loadJson(teacherJsonFileName));
}

bool LoginVerificationModel_c::verifyRegistrationTeacher(const User &_user)
{
    QJsonDocument usersInfoDoc = loadJson(teacherJsonFileName);
    QJsonObject usersInfoObj;
    QJsonArray usersInfoArray;
    if(usersInfoDoc.isObject())
    {
        usersInfoObj = usersInfoDoc.object();
        usersInfoArray = usersInfoObj["usersinfo"].toArray();
        foreach (const QJsonValue &currentUsersInfo, usersInfoArray)
        {
            QJsonObject currentUser = currentUsersInfo.toObject();
            if (_user.username == currentUser["username"].toString())
            {
                return false;
            }
        }
    }
    QJsonObject currentUser = createNewUser(_user);
    usersInfoArray.push_back(currentUser);
    if(!usersInfoObj.isEmpty())
    {
        usersInfoObj = QJsonObject();
    }
    usersInfoObj.insert("usersinfo", usersInfoArray);
    usersInfoDoc.setObject(usersInfoObj);
    saveJson(usersInfoDoc, teacherJsonFileName);
    return true;
}

bool LoginVerificationModel_c::verifyLoginStudent(const User &_user)
{
    return loginHelper(_user.username, _user.password, loadJson(studentJsonFileName));
}

bool LoginVerificationModel_c::verifyRegistrationStudent(const Student &_student)
{
    QJsonDocument usersInfoDoc = loadJson(studentJsonFileName);
    QJsonObject usersInfoObj;
    QJsonArray usersInfoArray;
    if(usersInfoDoc.isObject())
    {
        usersInfoObj = usersInfoDoc.object();
        usersInfoArray = usersInfoObj["usersinfo"].toArray();
        foreach (const QJsonValue &currentUsersInfo, usersInfoArray)
        {
            QJsonObject currentUser = currentUsersInfo.toObject();
            if (_student.username == currentUser["username"].toString())
            {
                return false;
            }
        }
    }
    QJsonObject currentUser = createNewStudent(_student);
    usersInfoArray.push_back(currentUser);
    if(!usersInfoObj.isEmpty())
    {
        usersInfoObj = QJsonObject();
    }
    usersInfoObj.insert("usersinfo", usersInfoArray);
    usersInfoDoc.setObject(usersInfoObj);
    saveJson(usersInfoDoc, studentJsonFileName);
    return true;
}

LoginVerificationModel_c *LoginVerificationModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new LoginVerificationModel_c;
    }
    return mInstance_ptr;
}
