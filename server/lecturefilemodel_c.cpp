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
    QDir directory(documents + "/CPPLearn/");
    bool pathExists = directory.cd(_lec.courseName);
    if(!pathExists)
    {
        directory.mkdir(_lec.courseName);
    }
    directory.setPath(directory.path() + _lec.courseName);
    QFile lectureFile(directory.filePath(_lec.name + ".html"));
    lectureFile.open(QFile::WriteOnly);
    lectureFile.write(_lec.text.toUtf8());
    lectureFile.close();
}

QStringList LectureFileModel_c::getLecturesNames(const QString &_course)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QDir directory(documents + "/CPPLearn/" + _course);
    QStringList lectures = directory.entryList(QStringList() << "*.html",QDir::Files);
    return lectures;
}

QString LectureFileModel_c::loadLectureText(const QString &_lectureName, const QString &_course)
{
    QString documents(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    QFile file(documents + "/CPPLearn/" + _course + _lectureName);
    file.open(QFile::ReadOnly | QFile::Text);
    QTextStream in(&file);
    return in.readAll();
}
