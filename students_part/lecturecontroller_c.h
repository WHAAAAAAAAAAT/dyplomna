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
    void onLectureRecieved(const QString &_lecture);

    QQuickTextDocument *document();
    void setDocument(QQuickTextDocument * _doc);

signals:
    void lectureRecieved();

private:
    QQuickTextDocument *mDocument_ptr;
};

