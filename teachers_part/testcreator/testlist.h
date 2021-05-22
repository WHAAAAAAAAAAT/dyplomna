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
    QVector<TestListItem> getItems();
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
    QStringList answers(int index);
    void setTestList(const Test &_test);

private:
    QString lectureName;
    QString courseName;
    QVector<TestListItem> mItems;
};

#endif // TESTLIST_H
