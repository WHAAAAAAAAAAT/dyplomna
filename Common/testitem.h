#pragma once

#include <QString>
#include <QStringList>

struct TestListItem
{
    bool check;
    QString question;
    QStringList answers;
    QString correctAnswer;
    QString linkToText;
};

struct Test
{
    QString courseName;
    QString lectureName;
    QVector<TestListItem> testList;
};
