#ifndef LECTURESCONTROLLER_C_H
#define LECTURESCONTROLLER_C_H

#include <QObject>
#include <QString>
#include <QQuickTextDocument>
#include <qqml.h>

class LecturesController_c : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LecturesController_c(QObject *parent = nullptr);

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

#endif // LECTURESCONTROLLER_C_H
