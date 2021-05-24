#pragma once

#include <QString>
#include <QStringList>

struct RecommendationItem
{
    QString question;
    QString linkToText;
};

struct RecommendationList
{
    QString courseName;
    QString lectureName;
    QString username;
    QVector<RecommendationItem> recommendations;
};
