#pragma once

#include <QString>
#include <QStringList>

struct AnswerItem
{
    QString question;
    QString answer;
};

struct StudentAnswers
{
    QString courseName;
    QString lectureName;
    QVector<AnswerItem> answerList;
};
