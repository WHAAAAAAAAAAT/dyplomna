#include "lecturecontroller_c.h"

#include "jsontypes.h"

#include "userinfomodel_c.h"
//#include "loginverificationmodel_c.h"
#include "networkmodel_c.h"
#include "notificationmodel_c.h"

LectureController_c::LectureController_c(QObject *parent) : QObject(parent)
{
    connect(NotificationModel_c::instance(), &NotificationModel_c::lectureRecieved, this, &LectureController_c::onLectureRecieved);
}

void LectureController_c::onLectureRecieved(const QString &_lecture)
{
    mDocument_ptr->textDocument()->setHtml(_lecture);
    emit lectureRecieved();
}

QQuickTextDocument *LectureController_c::document()
{
    return mDocument_ptr;
}

void LectureController_c::setDocument(QQuickTextDocument *_doc)
{
    mDocument_ptr = _doc;
}
