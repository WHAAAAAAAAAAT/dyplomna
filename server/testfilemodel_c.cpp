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
    QFile testFile(documents + "/CPPLearn/" + _courseName + "/" + _lectureName + "/" + _lectureName + ".json");
    testFile.open(QFile::ReadOnly | QFile::Text);
    QTextStream in(&testFile);
    in.setCodec("UTF-8");
    testFile.close();
    QJsonObject tempObj = QJsonDocument::fromJson(in.readAll().toUtf8()).object();
    tempObj[jsonKeys::title] = "Tests";
    qDebug() << "got tests json";
    return tempObj;
}



//Test TestFileModel_c::getTest(const QString &_courseName, const QString &_lectureName)
//{
//    Test test;

//    QString fileText;
//    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
//    QDir directory(documents + "/CPPLearn/" + _courseName + "/" + _lectureName + "/");
//    QFile testFile(directory.filePath(_lectureName + ".json"));
//    testFile.open(QFile::ReadOnly | QFile::Text);
//    QTextStream in(&testFile);
//    fileText = in.readAll();
//    testFile.close();

//    QJsonDocument tempDoc = QJsonDocument::fromJson(fileText.toUtf8());
//    QJsonObject testJson = tempDoc.object();

//    test = Network::jsonToTest(testJson);
//    return test;
//}
