#pragma once

#include <QObject>
#include <QString>
#include <qqml.h>

class LoginController_c : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LoginController_c(QObject *parent = nullptr);

public slots:
    void login(const QString &_username, const QString &_password);
    void registration(const QString &_name, const QString &_surname,
                      const QString &_username, const QString &_password);
signals:
    void loginError();
    void registrationError();
    void loginSuccess();
};
