#pragma once

#include <QObject>
#include <QString>
#include <QQmlEngine>
#include <QJSEngine>

#include "commondata.h"

class VerificationModel_c : public QObject
{
    Q_OBJECT
public:
    static VerificationModel_c* instance();

public slots:
    bool isUserExist(const User &_user);
private:
    explicit VerificationModel_c(QObject *_parent_ptr = nullptr);

private:
    static VerificationModel_c* mInstance_ptr;
};
