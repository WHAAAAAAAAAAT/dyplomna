#include "testlist.h"
#include <QDebug>
#include "networkmodel_c.h"
#include "notificationmodel_c.h"
#include "jsonconverter.h"

TestList::TestList(QObject *parent) : QObject(parent)
{
}

QVector<TestListItem> TestList::items() const
{
    return mItems;
}

QVector<AnswerItem> TestList::answers() const
{
    return mAnswers;
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

QString TestList::getLectureName() const
{
    return lectureName;
}

QString TestList::getCourseName() const
{
    return courseName;
}

QString TestList::getQuestion(int index) const
{
    return mItems.at(index).question;
}

QString TestList::getAnswerA(int index) const
{
    return mItems.at(index).answers.at(0);
}

QString TestList::getAnswerB(int index) const
{
    return mItems.at(index).answers.at(1);
}

QString TestList::getAnswerC(int index) const
{
    return mItems.at(index).answers.at(2);
}

QString TestList::getAnswerD(int index) const
{
    return mItems.at(index).answers.at(3);
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

void TestList::setAnswer(const QString &_question, const QString &_answer)
{
    if(mAnswers.size() == mItems.size())
    {
        clearAnswersList();
        return;
    }
    AnswerItem newItem;
    newItem.question = _question;
    newItem.answer = _answer;
    mAnswers.append(newItem);
}

void TestList::setTestList(const QVector<TestListItem> &_testList)
{
    clearTestList();
    if(_testList.size() == 0)
        appendItem();
    else
        for(auto item : _testList)
        {
            emit preItemAppended();
            mItems.append(item);
            emit postItemAppended();
        }
}

void TestList::setAnswersList(const QVector<AnswerItem> &_answers)
{
    while(mAnswers.size() > 0)
    {
        clearAnswersList();
    }
    for(auto item : _answers)
    {
        mAnswers.append(item);
        qDebug() << "item: " << item.question;
    }
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
        if (mItems.at(i).check)
        {
            emit preItemRemoved(i);
            mItems.removeAt(i);
            emit postItemRemoved();
        }
        else
            ++i;
    }
}

void TestList::clearTestList()
{
    for (int i{0}; i < mItems.size(); ++i)
    {
        emit preItemRemoved(i);
        mItems.removeAt(i);
        emit postItemRemoved();
    }
    mItems.clear();
}

void TestList::clearAnswersList()
{
    mAnswers.clear();
    qDebug() << "delete complited: " + QString::number(mAnswers.size());
}
