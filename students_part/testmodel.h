#ifndef TESTMODEL_H
#define TESTMODEL_H

#include <QObject>
#include <QAbstractListModel>

#include <QQmlEngine>
#include <QJSEngine>
#include "testitem.h"
#include "answeritem.h"

class TestList;

class TestModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(TestList *list READ list WRITE setList)

public:
    explicit TestModel(QObject *parent = nullptr);

    enum {
        CheckRole,
        QuestionRole,
        IndexRole,
        AnswersRole,
        CorrectAnswerRole,
        LinkToTextRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    TestList *list() const;
    void setList(TestList *list);
    void setTest(const Test &_test);
    void setAnswers(const StudentAnswers &_answers);

public slots:
    QString getTestQuestion(int index);
    QString getTestAnswerA(int index);
    QString getTestAnswerB(int index);
    QString getTestAnswerC(int index);
    QString getTestAnswerD(int index);
    int getTestSize();
    void setAnswer(const QString &_question, const QString &_answer);

    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static TestModel* instance();

private:
    static TestModel* mInstance_ptr;

    TestList *mList;
};

#endif // TESTMODEL_H
