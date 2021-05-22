#include "testlist.h"
#include <QDebug>
#include "networkmodel_c.h"
#include "notificationmodel_c.h"
#include "jsonconverter.h"

TestList::TestList(QObject *parent) : QObject(parent)
{
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

QVector<TestListItem> TestList::getItems()
{
    return mItems;
}

void TestList::setLectureName(const QString &_lectureName)
{
    lectureName = _lectureName;
}

void TestList::setCourseName(const QString &_courseName)
{
    courseName = _courseName;
}

QStringList TestList::answers(int index)
{
    return mItems.at(index).answers;
}

void TestList::setTestList(const Test &_test)
{
    emit preItemAppended();
    courseName = _test.courseName;
    lectureName = _test.lectureName;
    mItems = _test.testList;
    qDebug() << "testlist setTestList running";
    emit postItemAppended();
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
