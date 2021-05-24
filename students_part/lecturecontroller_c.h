#pragma once

#include <QObject>
#include <QString>
#include <qqml.h>
#include <QJsonObject>

#include "documenthandler.h"
#include <QQuickTextDocument>

class SearchHighLight;

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
    void selectText(const QString &_linkToText);

signals:
    void lectureSendingError();
    void lectureSendingSuccess();
    void lectureRecieved();

private:
    SearchHighLight* m_searchHighLight;
    QQuickTextDocument *mDocument_ptr;
};

