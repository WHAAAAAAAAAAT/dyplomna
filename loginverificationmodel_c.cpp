#include "loginverificationmodel_c.h"

#include <QDebug>

LoginVerificationModel_c *LoginVerificationModel_c::mInstance_ptr = nullptr;

LoginVerificationModel_c::LoginVerificationModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}

/*
  {
    "usersinfo": [
        {
            username
            name
            surname
            group
            password
        }
        {
            username
            ...
            password
        }
        {
            username
            ...
            password
        }
    ]
  }
*/

QJsonObject createNewUser(const QString &_username, const QString &_password,
                          const QString &_name, const QString &_surname,
                          const QString &_group)
{
    QJsonObject newUser;
    newUser.insert("username", QJsonValue::fromVariant(_username));
    newUser.insert("name", QJsonValue::fromVariant(_name));
    newUser.insert("surname", QJsonValue::fromVariant(_surname));
    newUser.insert("group", QJsonValue::fromVariant(_group));
    newUser.insert("password", QJsonValue::fromVariant(_password));
    return newUser;
}

bool LoginVerificationModel_c::registrationVerificationSuccessful(const QString &_username, const QString &_password,
                                                                  const QString &_name, const QString &_surname,
                                                                  const QString &_group)
{
    QJsonDocument usersInfoDoc = loadJson(jsonFileName);
    QJsonObject usersInfoObj;
    QJsonArray usersInfoArray;
    if(usersInfoDoc.isObject())
    {
        usersInfoObj = usersInfoDoc.object();
        usersInfoArray = usersInfoObj["usersinfo"].toArray();
        foreach (const QJsonValue &currentUsersInfo, usersInfoArray)
        {
            QJsonObject currentUser = currentUsersInfo.toObject();
            if(_username == currentUser["username"].toString())
            {
                //такий логін вже є, пака
                return false;
            }
            else
            {
                //логін не співпав, перевіряєм дальше
                continue;
            }
        }
    }
    //якщо об'єкт є і логін не співпав, начіт usersInfoObj і usersInfoArray вже ініціалізовані
    //тоді нам треба додати нового юзера в масив, очистити об'єкт і інсертнути в нього оновлений масив
    //якщо об'єкта не було, то і масив, і об'єкт пусті і до них просто додасться нова інфа
    //переписуєм док

    QJsonObject currentUser = createNewUser(_username, _password, _name, _surname, _group);
    usersInfoArray.push_back(currentUser);
    if(!usersInfoObj.isEmpty())
    {
        usersInfoObj = QJsonObject();
    }
    usersInfoObj.insert("usersinfo", usersInfoArray);
    usersInfoDoc.setObject(usersInfoObj);
    saveJson(usersInfoDoc, jsonFileName);
    return true;
}


bool LoginVerificationModel_c::loginVerificationSuccessful(const QString &_username, const QString &_password)
{
    QJsonDocument usersInfoDoc = loadJson(jsonFileName);
    if(usersInfoDoc.isObject())
    {
        QJsonObject usersInfoObj = usersInfoDoc.object();
        QJsonArray usersInfoArray = usersInfoObj["usersinfo"].toArray();
        foreach (const QJsonValue &currentUsersInfo, usersInfoArray)
        {
            QJsonObject currentUser = currentUsersInfo.toObject();
            if(_username == currentUser["username"].toString())
            {
                if(_password == currentUser["password"].toString())
                {
                    //логін співпав, пароль тоже, начіт всьо отлічно
                    return true;
                }
                else
                {
                    //логін співпав, пароль - ні, начіт доступа німа
                    return false;
                }
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

QJsonDocument LoginVerificationModel_c::loadJson(const QString &fileName)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents);
    bool pathExists = directory.cd("CPPLearn");
    if(!pathExists)
    {
        qDebug() << "load json, mkdir";
        directory.mkdir("CPPLearn");
    }
    directory.setPath(documents + "/CPPLearn");
    QFile jsonFile(directory.filePath(fileName));
    jsonFile.open(QFile::ReadWrite);

    qDebug() << "load json: " << jsonFile.isOpen();

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
        qDebug() << "save json, mkdir";
        directory.mkdir("CPPLearn");
    }
    directory.setPath(documents + "/CPPLearn");
    QFile jsonFile(directory.filePath(fileName));
    jsonFile.open(QFile::WriteOnly);

    qDebug() << jsonFile.isOpen();

    jsonFile.write(document.toJson());
    jsonFile.close();
}

LoginVerificationModel_c *LoginVerificationModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new LoginVerificationModel_c;
    }
    return mInstance_ptr;
}

QObject *LoginVerificationModel_c::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return LoginVerificationModel_c::instance();
}
