#pragma once

#include <QObject>
#include <QString>
#include <QQmlEngine>
#include <QJSEngine>

class NotificationModel_c : public QObject
{
    Q_OBJECT

public:
    static NotificationModel_c* instance();

private:
    explicit NotificationModel_c(QObject *_parent_ptr = nullptr);

signals:
    void loginFail();
    void loginSuccess();
    void registrationFail();
    void registrationSuccess();
    void lectureRecieved(const QString &lecture);

private:
    static NotificationModel_c* mInstance_ptr;
};
