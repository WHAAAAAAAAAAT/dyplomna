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
    void lectureCreation (QQuickTextDocument *_lecture);

signals:
    void lectureCreationError();
    void lectureCreationSuccess();
};

#endif // LECTURESCONTROLLER_C_H
