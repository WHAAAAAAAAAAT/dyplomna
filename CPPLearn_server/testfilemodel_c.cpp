#include "testfilemodel_c.h"

#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QDir>
#include <QStandardPaths>

TestFileModel_c* TestFileModel_c::mInstance_ptr = nullptr;

TestFileModel_c::TestFileModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}

TestFileModel_c *TestFileModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new TestFileModel_c;
    }
    return mInstance_ptr;
}

void TestFileModel_c::saveTest(const Test &_test, const QByteArray &_message)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/" + _test.courseName + "/" + _test.lectureName);
    QFile TestFile(directory.filePath(_test.lectureName + ".json"));
    TestFile.open(QFile::WriteOnly);
    TestFile.write(_message);
    qDebug() << "Test saved on server";
    TestFile.close();
}

QJsonObject TestFileModel_c::getTest(const QString &_courseName, const QString &_lectureName)
{
    QString fileText;
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));

    QDir directory(documents + "/CPPLearn/" + _courseName + "/");
    if(!directory.cd(_lectureName))
    {
        directory.mkdir(_lectureName);
    }
    QFile testFile(documents + "/CPPLearn/" + _courseName + "/" + _lectureName + "/" + _lectureName + ".json");
    if(testFile.open(QFile::ReadWrite | QFile::Text))
    {
        QTextStream in(&testFile);
        in.setCodec("UTF-8");
        QJsonObject tempObj = QJsonDocument::fromJson(in.readAll().toUtf8()).object();
        tempObj[jsonKeys::title] = "Tests";
        qDebug() << "got tests json";
        testFile.close();
        return tempObj;
    }
    QJsonObject tempObj;
    tempObj[jsonKeys::title] = "Tests";
    qDebug() << "can't get tests json";
    return tempObj;
}

void TestFileModel_c::saveAnswers(const StudentAnswers &_test, const QByteArray &_message)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/" + _test.courseName + "/" + _test.lectureName + "/");
    if(!directory.cd(_test.username))
    {
        directory.mkdir(_test.username);
    }
    QFile TestFile(documents + "/CPPLearn/" + _test.courseName + "/" +
                   _test.lectureName + "/" + _test.username + "/" + _test.username + ".json");
    TestFile.open(QFile::WriteOnly);
    TestFile.write(_message);
    qDebug() << "Answers are saved on server";
    TestFile.close();
}

QJsonObject TestFileModel_c::getAnswers(const QString &_courseName, const QString &_lectureName, const QString &_username)
{
    QString fileText;
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));

    QDir directory(documents + "/CPPLearn/" + _courseName + "/" + _lectureName + "/");
    if(!directory.cd(_username))
    {
        directory.mkdir(_username);
    }
    QFile testFile(documents + "/CPPLearn/" + _courseName + "/" + _lectureName + "/" + _username + "/" + _username + ".json");
    if(testFile.open(QFile::ReadWrite | QFile::Text))
    {
        QTextStream in(&testFile);
        in.setCodec("UTF-8");
        QJsonObject tempObj = QJsonDocument::fromJson(in.readAll().toUtf8()).object();
        tempObj[jsonKeys::title] = "Answers";
        qDebug() << "got answers json";
        testFile.close();
        return tempObj;
    }
    QJsonObject tempObj;
    tempObj[jsonKeys::title] = "Answers";
    qDebug() << "can't get answers json";
    return tempObj;
}
