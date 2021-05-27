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
#include "teacherinfomodel_c.h"
#include "logincontroller_c.h"
#include "lecturescontroller_c.h"
#include "testcontroller_c.h"
#include "documenthandler.h"
#include "testcreator/testmodel.h"
#include "testcreator/testlist.h"
#include "courselistmodel_c.h"

#include "networkmodel_c.h"

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

    const QDir writeDir = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    if (!writeDir.mkpath("."))
        qFatal("Failed to create writable directory at %s", qPrintable(writeDir.absolutePath()));

    const QString fileName = writeDir.absolutePath() + "/chat-database.sqlite3";
    database.setDatabaseName(fileName);
    if (!database.open()) {
        qFatal("Cannot open database: %s", qPrintable(database.lastError().text()));
        QFile::remove(fileName);
    }
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterType<DocumentHandler>("Controllers", 1, 0, "DocumentHandler");

    qmlRegisterSingletonType(QUrl("qrc:/UI/LoginConstants.qml"), "LoginPage", 1, 0, "LoginConstants");
    qmlRegisterSingletonType<TeacherInfoModel_c>("Models", 1, 0, "TeacherInfoModel_c", &TeacherInfoModel_c::qmlInstance);
    qmlRegisterType<LoginController_c>("Controllers", 1, 0, "LoginController");
    qmlRegisterType<LecturesController_c>("Controllers", 1, 0, "LecturesController");
    qmlRegisterType<TestController_c>("Controllers", 1, 0, "TestController");
    qmlRegisterSingletonType<TestModel>("Models", 1, 0, "TestModel", &TestModel::qmlInstance);
    qmlRegisterSingletonType<CourseListModel_c>("Models", 1, 0, "CourseModel", &CourseListModel_c::qmlInstance);
//    qmlRegisterUncreatableType<TestList>("Models", 1, 0, "TestList",
//                                         QStringLiteral("TestList should not be created in QML"));

    //chat database
    qmlRegisterType<SqlContactModel>("io.qt.examples.chattutorial", 1, 0, "SqlContactModel");
    qmlRegisterType<SqlConversationModel>("io.qt.examples.chattutorial", 1, 0, "SqlConversationModel");


#ifdef QT_WIDGETS_LIB
    QApplication app(argc, argv);
#else
    QGuiApplication app(argc, argv);
#endif
    auto network = NetworkModel_c::instance();
    Q_UNUSED(network)

    app.setWindowIcon(QIcon(":/UI/images/windowIcon.ico"));
    QFontDatabase fontDatabase;
    if (fontDatabase.addApplicationFont(":/fonts/fontello.ttf") == -1)
        qWarning() << "Failed to load fontello.ttf";

    connectToChatDatabase();

    TestList testList;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty(QStringLiteral("testList"), &testList);

    const QUrl url(QStringLiteral("qrc:/UI/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QApplication::setQuitOnLastWindowClosed(false);

    return app.exec();
}
