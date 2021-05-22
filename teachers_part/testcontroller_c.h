#pragma once

#include <QObject>
#include <QString>
#include <QQuickTextDocument>
#include <qqml.h>
<<<<<<< HEAD
#include "testitem.h"
=======
>>>>>>> 4b11e5461d67800f6d15d238e24cc76113f54f59

class TestController_c : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit TestController_c(QObject *parent = nullptr);

public slots:
<<<<<<< HEAD
    void saveTestList(QString _lectureName, QString _courseName);
    void loadTest(QString _lectureName, QString _courseName);

signals:
    void sendTestError();
    void sendTestSuccess();
=======
    void sendtest();
    void onTestRecieved(const QString &_test);

signals:
    void testSendingError();
    void testSendingSuccess();
>>>>>>> 4b11e5461d67800f6d15d238e24cc76113f54f59
    void testRecieved();
};
