#ifndef LOGINVERIFICATIONMODEL_C_H
#define LOGINVERIFICATIONMODEL_C_H

#include <QObject>
#include <QString>
#include <qqml.h>
#include <QDir>
#include <QJsonDocument>
#include <QJsonArray>
#include <QFile>
#include <QJsonValue>
#include <QJsonObject>
#include <QStandardPaths>

class LoginVerificationModel_c : QObject
{

public:
    static LoginVerificationModel_c *instance();
    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    QJsonDocument loadJson(const QString &fileName);
    void saveJson(const QJsonDocument &document, const QString &fileName);
    bool loginVerificationSuccessful(const QString &_username, const QString &_password);
    bool registrationVerificationSuccessful(const QString &_username, const QString &_password,
                                            const QString &_name, const QString &_surname);

private:
    explicit LoginVerificationModel_c(QObject *_parent_ptr = nullptr);
    static LoginVerificationModel_c *mInstance_ptr;
    const QString jsonFileName{"teachersinfo.json"};
};

#endif // LOGINVERIFICATIONMODEL_C_H
