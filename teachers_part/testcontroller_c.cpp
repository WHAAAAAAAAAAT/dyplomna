#include "testcontroller_c.h"

#include "networkmodel_c.h"
#include "jsonconverter.h"
#include "notificationmodel_c.h"
<<<<<<< HEAD
#include "testcreator/testmodel.h"
#include "testcreator/testlist.h"

TestController_c::TestController_c(QObject *parent) : QObject(parent)
{}

void TestController_c::saveTestList(QString _lectureName, QString _courseName)
{
    TestList *list = TestModel::instance()->list();
    list->setCourseName(_courseName);
    list->setLectureName(_lectureName);
    QJsonObject testDoc = JsonConverter::fromTestToJson(_courseName, _lectureName, list->getItems());
    if(NetworkModel_c::instance()->sendJson(testDoc))
    {
        qDebug() << "test send";
    }
    else
    {
        qDebug() << "test not send";
    }
}

void TestController_c::loadTest(QString _lectureName, QString _courseName)
{
    if(NetworkModel_c::instance()->sendJson(JsonConverter::fromLoadTestToJson(_courseName, _lectureName)))
    {
        qDebug() << "load tests send";
    }
    else {
        qDebug() << "load tests NOT send";
    }
}
=======
#include "courselistmodel_c.h"

TestController_c::TestController_c(QObject *parent) : QObject(parent)
{
//    connect(NotificationModel_c::instance(), &NotificationModel_c::testRecieved, this, &TestController_c::onLectureRecieved);
//    connect(CourseListModel_c::instance(), &CourseListModel_c::lectureRecived, this, &TestController_c::onLectureRecieved);
}

//void TestController_c::sendLecture(QQuickTextDocument *_lecture, const QString &_lectureName, const QString &_courseName)
//{
//    QJsonObject lectureJson = JsonConverter::fromLectureToJson(_lecture->textDocument()->toHtml(), _lectureName, _courseName);
//    if(NetworkModel_c::instance()->sendJson(lectureJson))
//    {
//        qDebug() << "lecture send";
//    }
//    else
//    {
//        qDebug() << "lecture not send";
//    }
//}

//void TestController_c::onLectureRecieved(const QString &_lecture)
//{
//    mDocument_ptr->textDocument()->setHtml(_lecture);
//    emit lectureRecieved();
//}

//QQuickTextDocument *TestController_c::document()
//{
//    return mDocument_ptr;
//}

//void TestController_c::setDocument(QQuickTextDocument *_doc)
//{
//    mDocument_ptr = _doc;
//}
>>>>>>> 4b11e5461d67800f6d15d238e24cc76113f54f59
