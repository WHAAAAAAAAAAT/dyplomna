#include "lecturescontroller_c.h"

#include "networkmodel_c.h"
#include "jsonconverter.h"

LecturesController_c::LecturesController_c(QObject *parent) : QObject(parent)
{

}

void LecturesController_c::sendLecture(QQuickTextDocument *_lecture, const QString &_lectureName, const QString &_courseName)
{
//    qDebug() << (_lecture->textDocument()->isEmpty() ? "Lecture is empty" : "Lecture is not empty");
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
