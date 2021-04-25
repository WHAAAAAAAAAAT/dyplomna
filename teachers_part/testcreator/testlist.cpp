#include "testlist.h"

TestList::TestList(QObject *parent) : QObject(parent)
{
    appendItem();
//    QStringList newList = {"a", "b", "c", "d"};
//    mItems.append({ false, QStringLiteral("abc"), newList, QStringLiteral("d"), QStringLiteral("ff") });
//    mItems.append({ false, QStringLiteral("efg"), newList, QStringLiteral("b"), QStringLiteral("fdf") });
//    mItems.append({ false, QStringLiteral("hij"), newList, QStringLiteral("a"), QStringLiteral("yaf") });

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

QStringList TestList::answers(int index)
{
    return mItems.at(index).answers;
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
