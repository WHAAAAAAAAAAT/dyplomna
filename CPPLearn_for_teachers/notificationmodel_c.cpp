#include "notificationmodel_c.h"

#include <QDebug>

NotificationModel_c* NotificationModel_c::mInstance_ptr = nullptr;

NotificationModel_c::NotificationModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}

NotificationModel_c *NotificationModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new NotificationModel_c;
    }
    return mInstance_ptr;
}
