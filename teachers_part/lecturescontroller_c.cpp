#include "lecturescontroller_c.h"

#include "networkmodel_c.h"
#include "jsonconverter.h"
#include "notificationmodel_c.h"
#include "courselistmodel_c.h"

LecturesController_c::LecturesController_c(QObject *parent) : QObject(parent)
{
    connect(NotificationModel_c::instance(), &NotificationModel_c::lectureRecieved, this, &LecturesController_c::onLectureRecieved);
    connect(CourseListModel_c::instance(), &CourseListModel_c::lectureRecived, this, &LecturesController_c::onLectureRecieved);
}

void LecturesController_c::sendLecture(QQuickTextDocument *_lecture, const QString &_lectureName, const QString &_courseName)
{
    QJsonObject lectureJson = JsonConverter::fromLectureToJson(_lecture->textDocument()->toHtml(), _lectureName, _courseName);
    if(NetworkModel_c::instance()->sendJson(lectureJson))
    {
        qDebug() << "lecture send";
    }
    else
    {
        qDebug() << "lecture not send";
    }
}

void LecturesController_c::onLectureRecieved(const QString &_lecture)
{
    mDocument_ptr->textDocument()->setHtml(_lecture);
    emit lectureRecieved();
}

QQuickTextDocument *LecturesController_c::document()
{
    return mDocument_ptr;
}

void LecturesController_c::setDocument(QQuickTextDocument *_doc)
{
    mDocument_ptr = _doc;
}
