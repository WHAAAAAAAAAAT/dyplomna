#pragma once

#include <QObject>
#include <QString>

#include "commondata.h"

class TestFileModel_c : public QObject
{
    Q_OBJECT
public:
    static TestFileModel_c* instance();

    void saveTest(const Test &_test, const QByteArray &_message);
    QJsonObject getTest(const QString &_courseName, const QString &_lectureName);

private:
    explicit TestFileModel_c(QObject *_parent_ptr = nullptr);

private:
    static TestFileModel_c* mInstance_ptr;
};
