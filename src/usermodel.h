#ifndef USERMODEL_H
#define USERMODEL_H

#include <QString>

class UserModel
{
private:
    QString mUsername;
    QString mPassword;
    QString mGroup;
public:
    UserModel();
    static UserModel* instance();
    QString getUsername();
    QString getPassword();
    QString getGroup();
    void setUsername(const QString &username);
    void setPassword(const QString &password);
    void setGroup(const QString &group);
};

#endif // USERMODEL_H
