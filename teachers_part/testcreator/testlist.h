#ifndef TESTLIST_H
#define TESTLIST_H

#include <QObject>
#include <QVector>

struct TestListItem
{
    bool check;
    QString question;
    QStringList answers;
    QString correctAnswer;
    QString linkToText;
};

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

private:
    QVector<TestListItem> mItems;
};

#endif // TESTLIST_H
