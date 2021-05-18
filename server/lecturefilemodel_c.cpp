#include "lecturefilemodel_c.h"

#include <QDebug>
#include <QFile>
#include <QDir>
#include <QStandardPaths>


LectureFileModel_c* LectureFileModel_c::mInstance_ptr = nullptr;

LectureFileModel_c::LectureFileModel_c(QObject *_parent_ptr)
    : QObject(_parent_ptr)
{}

LectureFileModel_c *LectureFileModel_c::instance()
{
    if (!mInstance_ptr)
    {
        mInstance_ptr = new LectureFileModel_c;
    }
    return mInstance_ptr;
}

void LectureFileModel_c::saveLecture(const Lecture &_lec)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/" + _lec.courseName + "/");
    bool pathExists = directory.cd(_lec.name);
    if(!pathExists)
    {
        directory.mkdir(_lec.name);
    }
    QFile lectureFile(documents + "/CPPLearn/" + _lec.courseName + "/" + _lec.name + "/" + _lec.name + ".html");
    lectureFile.open(QFile::WriteOnly);
    lectureFile.write(_lec.text.toUtf8());
    qDebug() << "lecture saved on server";
    lectureFile.close();
}

QJsonObject LectureFileModel_c::getLectures(QString _courseName)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/" + _courseName + "/");
    QStringList lecturesNames = directory.entryList(QDir::AllDirs | QDir::NoDotAndDotDot);
    qDebug() << "lectures list: " << lecturesNames;
    QJsonObject tempObj;
    tempObj[jsonKeys::title] = "Lectures";
    for(int i{0}; i < lecturesNames.size(); ++i)
    {
        QJsonObject tempLec;
        for(int j{0}; j < lecturesNames.size(); ++j)
        {
            tempLec["Name"] = lecturesNames.at(j);
            tempLec["Course"] = _courseName;
            tempLec["Text"] = loadLectureText(lecturesNames.at(j), _courseName);
        }
        tempObj["Lecture " + QString::number(i)] = tempLec;
    }
    qDebug() << "got lectures";
    return tempObj;
}

QString LectureFileModel_c::loadLectureText(const QString &_lectureName, const QString &_course)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/" + _course + "/");
    bool pathExists = directory.cd(_lectureName);
    if(!pathExists)
    {
        directory.mkdir(_lectureName);
        QFile file(documents + "/CPPLearn/" + _course + "/" + _lectureName + "/" + _lectureName + ".html");
        file.open(QFile::ReadWrite | QFile::Text);
        QTextStream in(&file);
        in.setCodec("UTF-8");
        return in.readAll();
    }
    QFile file(documents + "/CPPLearn/" + _course + "/" + _lectureName + "/" + _lectureName + ".html");
    file.open(QFile::ReadOnly | QFile::Text);
    QTextStream in(&file);
    in.setCodec("UTF-8");
    return in.readAll();
}

