#pragma once

#include <QObject>
#include <QString>
#include <QQuickTextDocument>
#include <qqml.h>
#include "testitem.h"

class TestController_c : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit TestController_c(QObject *parent = nullptr);

public slots:
    void saveTestList(QString _lectureName, QString _courseName);
    void loadTest(QString _lectureName, QString _courseName);
    void clearTest();
    void clearAnswers();

signals:
    void sendTestError();
    void sendTestSuccess();
};
