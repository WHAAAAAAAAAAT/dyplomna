#include "testlist.h"
#include <QDebug>
#include "networkmodel_c.h"
#include "notificationmodel_c.h"
#include "jsonconverter.h"

TestList::TestList(QObject *parent) : QObject(parent)
{
//    if(NetworkModel_c::instance()->sendJson(JsonConverter::fromLoadTestToJson(mList->getCourseName(), mList->getLectureName())))
//    {
//        qDebug() << "load tests send";
//    }
//    else {
//        qDebug() << "load tests NOT send";
//    }
    appendItem();
}

QVector<TestListItem> TestList::items() const
{
    return mItems;
}

bool TestList::setItemAt(int index, const TestListItem &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const TestListItem &oldItem = mItems.at(index);
    if ( (item.check == oldItem.check) && (item.question == oldItem.question) && (item.answers == oldItem.answers)
         && (item.correctAnswer == oldItem.correctAnswer) && (item.linkToText == oldItem.linkToText))
        return false;

    mItems[index] = item;
    return true;
}

QString TestList::getLectureName()
{
    return lectureName;
}

QString TestList::getCourseName()
{
    return courseName;
}

QStringList TestList::answers(int index)
{
    return mItems.at(index).answers;
}

void TestList::saveTestList(QString _lectureName, QString _courseName)
{
    lectureName = _lectureName;
    courseName = _courseName;
    QJsonObject testDoc = JsonConverter::fromTestToJson(_courseName, _lectureName, mItems);
    if(NetworkModel_c::instance()->sendJson(testDoc))
    {
        qDebug() << "test send";
    }
    else
    {
        qDebug() << "test not send";
    }
}

void TestList::setTestList(const Test &_test)
{
    emit preItemAppended();
    lectureName = _test.lectureName;
    mItems = _test.testList;
    qDebug() << "testlist setTestList running";
    emit postItemAppended();
//    emit updateTest(this);
}

void TestList::appendItem()
{
    emit preItemAppended();

    TestListItem item;
    QStringList newList = {"", "", "", ""};
    item.check = false;
    item.answers = newList;
    mItems.append(item);

    emit postItemAppended();
}

void TestList::removeCompletedItems()
{
    for (int i = 0; i < mItems.size(); )
    {
        if (mItems.at(i).check) {
            emit preItemRemoved(i);

            mItems.removeAt(i);

            emit postItemRemoved();
        } else {
            ++i;
        }
    }
}
