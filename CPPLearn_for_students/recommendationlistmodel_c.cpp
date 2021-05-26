#include "recommendationlistmodel_c.h"

RecommendationListModel_c* RecommendationListModel_c::mInstance_ptr = nullptr;

RecommendationListModel_c:: RecommendationListModel_c (QObject *parent) : QAbstractListModel(parent)
{
}
int RecommendationListModel_c::rowCount(const QModelIndex &parent) const{
    if (parent.isValid())
        return 0;
    return mRecommendations.size();
}
QVariant RecommendationListModel_c::data(const QModelIndex &indexM, int role) const
{
    if (!indexM.isValid())
        return QVariant();
    const RecommendationItem item = mRecommendations.at(indexM.row());
    switch (role) {
    case QuestionRole:
        return QVariant(item.question);
    case LinkToTextRole:
        return QVariant(item.linkToText);
    }
    return QVariant();
}

bool RecommendationListModel_c::setData(const QModelIndex &indexM, const QVariant &value, int role)
{
    auto item = mRecommendations.at(indexM.row());
    switch (role) {
    case QuestionRole:
        item.question = value.toString();
        break;
    case LinkToTextRole:
        item.linkToText = value.toString();
        break;
    }
    if (indexM.row() < 0 || indexM.row() >= mRecommendations.size())
        return false;
    mRecommendations[indexM.row()] = item;
    emit dataChanged(indexM, indexM, QVector<int>() << role);
    return true;
}
QHash<int, QByteArray> RecommendationListModel_c::roleNames() const
{
    QHash<int, QByteArray> names;
    names[QuestionRole] = "question";
    names[LinkToTextRole] = "linkToText";
    return names;
}
QObject *RecommendationListModel_c::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return RecommendationListModel_c::instance();
}
RecommendationListModel_c *RecommendationListModel_c::instance()
{
    if (!mInstance_ptr)
        mInstance_ptr = new RecommendationListModel_c;
    return mInstance_ptr;
}

void RecommendationListModel_c::createRecommendations(const QVector<TestListItem> &_tests, const QVector<AnswerItem> &_answers)
{
    int counter{0};
    for (auto currentQuestion : _answers)
    {
        for (int i{0}; i < _tests.size(); ++i)
        {
            if (currentQuestion.question == _tests.at(i).question)
            {
                if (currentQuestion.answer != _tests.at(i).correctAnswer)
                {
                    RecommendationItem tempItem;
                    tempItem.question = _tests.at(i).question;
                    tempItem.linkToText = _tests.at(i).linkToText;
                    mRecommendations.append(tempItem);
                }
                else {
                    ++counter;
                }
            }
        }
    }
    testScore = static_cast<int>(100.0 * counter/_tests.size());
    result = QString::number(counter) + "/" + QString::number(_tests.size());
    emit dataChanged(index(0,0), index(mRecommendations.size() - 1, 0));
}

QString RecommendationListModel_c::testResults()
{
    return result;
}

void RecommendationListModel_c::clearRecommendations()
{
    mRecommendations.clear();
    result = "";
}

int RecommendationListModel_c::testSize()
{
    return mRecommendations.size();
}

int RecommendationListModel_c::score()
{
    return testScore;
}
