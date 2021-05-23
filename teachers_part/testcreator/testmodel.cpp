#include "testmodel.h"

#include "testlist.h"
#include "networkmodel_c.h"
#include "jsonconverter.h"

TestModel* TestModel::mInstance_ptr = nullptr;

TestModel::TestModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(new TestList)
{
}

QObject *TestModel::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return TestModel::instance();
}

TestModel *TestModel::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new TestModel;
    }
    return mInstance_ptr;
}


int TestModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid() || !mList)
        return 0;

    return mList->items().size();
}

QVariant TestModel::data(const QModelIndex &indexM, int role) const
{
    if (!indexM.isValid() || !mList)
        return QVariant();

    const TestListItem item = mList->items().at(indexM.row());
    switch (role) {
    case CheckRole:
        return QVariant(item.check);
    case QuestionRole:
        return QVariant(item.question);
    case AnswersRole:
        return QVariant(item.answers);
    case CorrectAnswerRole:
        return QVariant(item.correctAnswer);
    case LinkToTextRole:
        return QVariant(item.linkToText);
    case IndexRole:
        return QVariant(indexM.row());
    }

    return QVariant();
}

bool TestModel::setData(const QModelIndex &indexM, const QVariant &value, int role)
{
    if (!mList)
        return false;

    TestListItem item = mList->items().at(indexM.row());
    switch (role) {
    case CheckRole:
        item.check = value.toBool();
        break;
    case QuestionRole:
        item.question = value.toString();
        break;
    case AnswersRole:
        item.answers = value.toStringList();
        break;
    case CorrectAnswerRole:
        item.correctAnswer = value.toString();
        break;
    case LinkToTextRole:
        item.linkToText = value.toString();
        break;
    }

    if (mList->setItemAt(indexM.row(), item)) {
        emit dataChanged(indexM, indexM, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags TestModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> TestModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[CheckRole] = "check";
    names[QuestionRole] = "question";
    names[IndexRole] = "index";
    names[AnswersRole] = "answers";
    names[CorrectAnswerRole] = "correctAnswer";
    names[LinkToTextRole] = "linkToText";
    return names;
}

TestList *TestModel::list() const
{
    return mList;
}

void TestModel::setList(TestList *list)
{
    beginResetModel();

    if (mList)
        mList->disconnect(this);

    mList = list;

    if (mList) {
        connect(mList, &TestList::preItemAppended, this, [=]() {
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });
        connect(mList, &TestList::postItemAppended, this, [=]() {
            endInsertRows();
        });

        connect(mList, &TestList::preItemRemoved, this, [=](int index) {
            beginRemoveRows(QModelIndex(), index, index);
        });
        connect(mList, &TestList::postItemRemoved, this, [=]() {
            endRemoveRows();
        });
    }
    endResetModel();
}

void TestModel::setTest(const Test &_test)
{
    beginResetModel();

    mList->setCourseName(_test.courseName);
    mList->setLectureName(_test.lectureName);
    mList->setTestList(_test.testList);
    emit dataChanged(index(0,0), index(mList->items().size() - 1, 0), {Qt::EditRole, Qt::DisplayRole});

    endResetModel();

}
