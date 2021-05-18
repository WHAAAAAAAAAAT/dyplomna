#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

#include <userinfomodel_c.h>
#include <logincontroller_c.h>
#include "documenthandler.h"
#include "lecturecontroller_c.h"
#include "networkmodel_c.h"
#include "courselistmodel_c.h"


#include <QSqlDatabase>
#include <QSqlError>
#include <QStandardPaths>
#include <QDir>
#include "chat/sqlcontactmodel.h"
#include "chat/sqlconversationmodel.h"

static void connectToChatDatabase()
{
    QSqlDatabase database = QSqlDatabase::database();
    if (!database.isValid()) {
        database = QSqlDatabase::addDatabase("QSQLITE");
        if (!database.isValid())
            qFatal("Cannot add database: %s", qPrintable(database.lastError().text()));
    }

    const QDir writeDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    if (!writeDir.mkpath("."))
        qFatal("Failed to create writable directory at %s", qPrintable(writeDir.absolutePath()));

    // Ensure that we have a writable location on all devices.
    const QString fileName = writeDir.absolutePath() + "/chat-database.sqlite3";
    // When using the SQLite driver, open() will create the SQLite database if it doesn't exist.
    database.setDatabaseName(fileName);
    if (!database.open()) {
        qFatal("Cannot open database: %s", qPrintable(database.lastError().text()));
        QFile::remove(fileName);
    }
}

int main(int argc, char *argv[])  
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterSingletonType(QUrl("qrc:/UI/ClientLoginConstants.qml"), "LoginPage", 1, 0, "ClientLoginConstants");
    qmlRegisterSingletonType<UserInfoModel_c>("Models", 1, 0, "UserInfoModel", &UserInfoModel_c::qmlInstance);
    qmlRegisterSingletonType<CourseListModel_c>("Models", 1, 0, "CourseModel", &CourseListModel_c::qmlInstance);
    qmlRegisterType<LoginController_c>("Controllers", 1, 0, "ClientLoginController");
    qmlRegisterType<DocumentHandler>("Controllers", 1, 0, "DocumentHandler");
    qmlRegisterType<LectureController_c>("Controllers", 1, 0, "LectureController");

    //chat database
    qmlRegisterType<SqlContactModel>("io.qt.examples.chattutorial", 1, 0, "SqlContactModel");
    qmlRegisterType<SqlConversationModel>("io.qt.examples.chattutorial", 1, 0, "SqlConversationModel");

    connectToChatDatabase();

    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/UI/images/windowIcon.ico"));

    QQmlApplicationEngine engine;

    auto network = NetworkModel_c::instance();
    Q_UNUSED(network)

    const QUrl url(QStringLiteral("qrc:/UI/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
