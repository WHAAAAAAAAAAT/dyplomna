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

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

public slots:
    void appendItem();
    void removeCompletedItems();
    QStringList answers(int index);
    void saveTestList(QString _lectureName, QString _courseName);

private:
    QString lectureName;
    QVector<TestListItem> mItems;
};

#endif // TESTLIST_H
