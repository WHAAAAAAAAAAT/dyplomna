#pragma once

#include <QObject>
#include <QString>

#include "commondata.h"

class LectureFileModel_c : public QObject
{
    Q_OBJECT
public:
    static LectureFileModel_c* instance();

    void saveLecture(const Lecture &_lec);
    QString loadLectureText(const QString &_lectureName, const QString &_course);
    QJsonObject getLectures(QString _courseName);

private:
    explicit LectureFileModel_c(QObject *_parent_ptr = nullptr);

private:
    static LectureFileModel_c* mInstance_ptr;
};
