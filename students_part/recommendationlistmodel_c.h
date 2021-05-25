#pragma once

#include <QObject>
#include <QAbstractListModel>

#include "testmodel.h"
#include "recommendationitem.h"

#include <QQmlEngine>
#include <QJSEngine>

class RecommendationListModel_c : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit RecommendationListModel_c(QObject *parent = nullptr);

    enum {
        QuestionRole,
        LinkToTextRole
    };

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static RecommendationListModel_c* instance();

public slots:
    void createRecommendations(const QVector<TestListItem> &_tests, const QVector<AnswerItem> &_answers);
    QString testResults();
    void clearRecommendations();
    int testSize();
    int score();

private:
    static RecommendationListModel_c* mInstance_ptr;
    QVector<RecommendationItem> mRecommendations;
    QString result;
    int testScore{0};
};
