#pragma once

#include <QObject>
#include <QString>

#include "commondata.h"
#include "lecture.h"

class LectureFileModel_c : public QObject
{
    Q_OBJECT
public:
    static LectureFileModel_c* instance();

    void saveLecture(const Lecture &_lec);
    QStringList getLecturesNames(const QString &_course);
    QString loadLectureText(const QString &_lectureName, const QString &_course);

private:
    explicit LectureFileModel_c(QObject *_parent_ptr = nullptr);

private:
    static LectureFileModel_c* mInstance_ptr;
};
