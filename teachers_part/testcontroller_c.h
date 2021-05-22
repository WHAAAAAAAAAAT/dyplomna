#pragma once

#include <QObject>
#include <QString>
#include <QQuickTextDocument>
#include <qqml.h>

class TestController_c : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit TestController_c(QObject *parent = nullptr);

public slots:
    void sendtest();
    void onTestRecieved(const QString &_test);

signals:
    void testSendingError();
    void testSendingSuccess();
    void testRecieved();
};
