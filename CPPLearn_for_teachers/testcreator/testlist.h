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
    QString getLectureName() const;
    QString getCourseName() const;
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
    QStringList answers(int index);
    void setTestList(const QVector<TestListItem> &_testList);

private:
    QString lectureName;
    QString courseName;
    QVector<TestListItem> mItems;
};

#endif // TESTLIST_H
