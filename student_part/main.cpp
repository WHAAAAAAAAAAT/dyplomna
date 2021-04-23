#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <userinfomodel_c.h>
#include <logincontroller_c.h>
#include "documenthandler.h"
#include "lecturecontroller_c.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterSingletonType(QUrl("qrc:/UI/ClientLoginConstants.qml"), "LoginPage", 1, 0, "ClientLoginConstants");
    qmlRegisterSingletonType<UserInfoModel_c>("Models", 1, 0, "UserInfoModel_c", &UserInfoModel_c::qmlInstance);
    qmlRegisterType<LoginController_c>("Controllers", 1, 0, "ClientLoginController");
    qmlRegisterType<DocumentHandler>("Controllers", 1, 0, "DocumentHandler");
    qmlRegisterType<LectureController_c>("Controllers", 1, 0, "LectureController");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/UI/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
