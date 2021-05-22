#pragma once

#include <QObject>
#include <QString>
#include <qqml.h>
#include <QJsonObject>

#include "documenthandler.h"
#include <QQuickTextDocument>
class LectureController_c : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LectureController_c(QObject *parent = nullptr);

public slots:
    void sendLecture(QQuickTextDocument *_lecture, const QString &_lectureName, const QString &_courseName);
    void onLectureRecieved(const QString &_lecture);
    QQuickTextDocument *document();
    void setDocument(QQuickTextDocument * _doc);

signals:
    void lectureSendingError();
    void lectureSendingSuccess();
    void lectureRecieved();

private:
    QQuickTextDocument *mDocument_ptr;
};

