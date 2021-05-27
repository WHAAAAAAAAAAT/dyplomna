#include "testcontroller_c.h"

#include "networkmodel_c.h"
#include "jsonconverter.h"
#include "notificationmodel_c.h"
#include "testcreator/testmodel.h"
#include "testcreator/testlist.h"

TestController_c::TestController_c(QObject *parent) : QObject(parent)
{}

void TestController_c::saveTestList(QString _lectureName, QString _courseName)
{
    TestList *list = TestModel::instance()->list();
    list->setCourseName(_courseName);
    list->setLectureName(_lectureName);
    QJsonObject testDoc = JsonConverter::fromTestToJson(_courseName, _lectureName, list->items());
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

void TestController_c::clearTest()
{
    TestModel::instance()->list()->clearTestList();
}
