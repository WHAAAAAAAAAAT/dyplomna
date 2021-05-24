#include "testcontroller_c.h"

#include "networkmodel_c.h"
#include "jsonconverter.h"
#include "notificationmodel_c.h"
#include "testmodel.h"
#include "testlist.h"
#include "recommendationlistmodel_c.h"

TestController_c::TestController_c(QObject *parent) : QObject(parent)
{}

void TestController_c::saveTestList(QString _lectureName, QString _courseName)
{
    TestList *list = TestModel::instance()->list();
    QJsonObject answersDoc = JsonConverter::fromAnswersToJson(_courseName, _lectureName, list->answers());
    if(NetworkModel_c::instance()->sendJson(answersDoc))
    {
        qDebug() << "answers send";
        RecommendationListModel_c::instance()->createRecommendations(list->items(), list->answers());
        clearAnswers();
        clearTest();
    }
    else
    {
        qDebug() << "answers not send";
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
    TestList *list = TestModel::instance()->list();
    list->clearTestList();
}

void TestController_c::clearAnswers()
{
    TestList *list = TestModel::instance()->list();
    list->clearAnswersList();
}
