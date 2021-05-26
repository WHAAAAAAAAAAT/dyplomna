#ifndef TESTLIST_H
#define TESTLIST_H

#include <QObject>
#include <QVector>
#include "testitem.h"
#include "answeritem.h"

class TestList : public QObject
{
    Q_OBJECT
public:
    explicit TestList(QObject *parent = nullptr);

    QVector<TestListItem> items() const;
    QVector<AnswerItem> answers() const;

    bool setItemAt(int index, const TestListItem &item);
    QString getLectureName() const;
    QString getCourseName() const;
    QString getQuestion(int index) const;
    QString getAnswerA(int index) const;
    QString getAnswerB(int index) const;
    QString getAnswerC(int index) const;
    QString getAnswerD(int index) const;
    void setLectureName(const QString &_lectureName);
    void setCourseName(const QString &_courseName);

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

public slots:
    void appendItem();
    void removeCompletedItems();
    void clearTestList();
    void clearAnswersList();
    QStringList answers(int index);
    void setAnswer(const QString &_question, const QString &_answer);
    void setTestList(const QVector<TestListItem> &_testList);
    void setAnswersList(const QVector<AnswerItem> &_answers);

private:
    QString lectureName;
    QString courseName;
    QVector<TestListItem> mItems;
    QVector<AnswerItem> mAnswers;
};

#endif // TESTLIST_H
