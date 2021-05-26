#pragma once

#include <QObject>
#include <QString>
#include <qqml.h>
#include <QJsonObject>

class LoginController_c : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LoginController_c(QObject *parent = nullptr);

public slots:
    void login(const QString &_username, const QString &_password);
    void registration(const QString &_name, const QString &_surname, const QString &_group,
                      const QString &_username, const QString &_password);

    QJsonObject createLoginJson(const QString &_username, const QString &_password);
    QJsonObject createRegistrationJson(const QString &_name, const QString &_surname, const QString &_group,
                                       const QString &_username, const QString &_password);

    void onLoginSuccess();
    void onLoginFail();
    void onRegistrationSuccess();
    void onRegistrationFail();

signals:
    void loginFail();
    void loginSuccess();
    void registrationFail();
    void registrationSuccess();
};

