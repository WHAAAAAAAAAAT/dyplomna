#ifdef QT_WIDGETS_LIB
#include <QApplication>
#else
#include <QGuiApplication>
#endif
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlFileSelector>
#include <QQuickStyle>
#include "userinfomodel_c.h"
#include "logincontroller_c.h"
#include "documenthandler.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterType<DocumentHandler>("Controllers", 1, 0, "DocumentHandler");

    qmlRegisterSingletonType(QUrl("qrc:/UI/LoginConstants.qml"), "LoginPage", 1, 0, "LoginConstants");
    qmlRegisterSingletonType<UserInfoModel_c>("Models", 1, 0, "UserInfoModel_c", &UserInfoModel_c::qmlInstance);
    qmlRegisterType<LoginController_c>("Controllers", 1, 0, "LoginController");

#ifdef QT_WIDGETS_LIB
    QApplication app(argc, argv);
#else
    QGuiApplication app(argc, argv);
#endif
    app.setWindowIcon(QIcon(":/UI/images/windowIcon.png"));
    QFontDatabase fontDatabase;
    if (fontDatabase.addApplicationFont(":/fonts/fontello.ttf") == -1)
        qWarning() << "Failed to load fontello.ttf";

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
