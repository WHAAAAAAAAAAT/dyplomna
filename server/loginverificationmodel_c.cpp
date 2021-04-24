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
                //логін не співпав, шукаєм дальше
                continue;
            }
        }
    }
    else
    {
        //нема об'єкта, начіт джсон пустий і ще ніхто не зарєганий
        return false;
    }
    //якщо логін так і не співпав, начіт такого юзера німа
    return false;
}

QJsonObject LoginVerificationModel_c::createNewUser(const QString &_username, const QString &_password, const QString &_name, const QString &_surname)
{
    QJsonObject newUser;
    newUser.insert(jsonKeys::username, QJsonValue::fromVariant(_username));
    newUser.insert(jsonKeys::name, QJsonValue::fromVariant(_name));
    newUser.insert(jsonKeys::surname, QJsonValue::fromVariant(_surname));
    newUser.insert(jsonKeys::password, QJsonValue::fromVariant(_password));
    return newUser;
}

QJsonObject LoginVerificationModel_c::createNewStudent(const QString &_username, const QString &_password, const QString &_name, const QString &_surname, const QString &_group)
{
    auto student = createNewUser(_username, _password, _name, _surname);
    student.insert(jsonKeys::group, QJsonValue::fromVariant(_group));
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

bool LoginVerificationModel_c::verifyLoginTeacher(const QString &_username, const QString &_password)
{
    return loginHelper(_username, _password, loadJson(teacherJsonFileName));
}

bool LoginVerificationModel_c::verifyRegistrationTeacher(const QString &_username, const QString &_password, const QString &_name, const QString &_surname)
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
            return (_username == currentUser["username"].toString());
        }
    }
    //якщо об'єкт є і логін не співпав, начіт usersInfoObj і usersInfoArray вже ініціалізовані
    //тоді нам треба додати нового юзера в масив, очистити об'єкт і інсертнути в нього оновлений масив
    //якщо об'єкта не було, то і масив, і об'єкт пусті і до них просто додасться нова інфа
    //переписуєм док

    QJsonObject currentUser = createNewUser(_username, _password, _name, _surname);
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

bool LoginVerificationModel_c::verifyLoginStudent(const QString &_username, const QString &_password)
{
    return loginHelper(_username, _password, loadJson(studentJsonFileName));
}

bool LoginVerificationModel_c::verifyRegistrationStudent(const QString &_username, const QString &_password, const QString &_name, const QString &_surname, const QString &_group)
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
            return (_username == currentUser["username"].toString());
        }
    }
    //якщо об'єкт є і логін не співпав, начіт usersInfoObj і usersInfoArray вже ініціалізовані
    //тоді нам треба додати нового юзера в масив, очистити об'єкт і інсертнути в нього оновлений масив
    //якщо об'єкта не було, то і масив, і об'єкт пусті і до них просто додасться нова інфа
    //переписуєм док

    QJsonObject currentUser = createNewStudent(_username, _password, _name, _surname, _group);
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

LoginVerificationModel_c *LoginVerificationModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new LoginVerificationModel_c;
    }
    return mInstance_ptr;
}
