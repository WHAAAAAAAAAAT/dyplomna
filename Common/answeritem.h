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
    QString username;
    int score;
    QVector<AnswerItem> answerList;
};
