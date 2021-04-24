#ifndef USER_H
#define USER_H

#include <QObject>

class User
{
public:
    QString username;
    QString password;
    QString name;
    QString surname;
};

class Student : public User
{
public:
    QString mGroup;
};

class Teacher : public User
{
};

#endif // USER_H
