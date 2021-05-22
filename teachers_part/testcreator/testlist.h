#ifndef TESTLIST_H
#define TESTLIST_H

#include <QObject>
#include <QVector>
#include "testitem.h"

class TestList : public QObject
{
    Q_OBJECT
public:
    explicit TestList(QObject *parent = nullptr);

    QVector<TestListItem> items() const;

    bool setItemAt(int index, const TestListItem &item);
    QString getLectureName();
    QString getCourseName();

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();
//    void updateTest(TestList *list);

public slots:
    void appendItem();
    void removeCompletedItems();
    QStringList answers(int index);
    void saveTestList(QString _lectureName, QString _courseName);
    void setTestList(const Test &_test);

private:
    QString lectureName;
    QString courseName;
    QVector<TestListItem> mItems;
};

#endif // TESTLIST_H
