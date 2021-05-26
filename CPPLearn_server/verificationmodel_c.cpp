#include "verificationmodel_c.h"

#include <QDebug>
VerificationModel_c* VerificationModel_c::mInstance_ptr = nullptr;

VerificationModel_c::VerificationModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}

VerificationModel_c *VerificationModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new VerificationModel_c;
    }
    return mInstance_ptr;
}

bool VerificationModel_c::isUserExist(const User &_user)
{
    // TODO
    return true;
}

