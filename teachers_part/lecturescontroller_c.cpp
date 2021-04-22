#include "lecturescontroller_c.h"


#include "networkmodel_c.h"

LecturesController_c::LecturesController_c(QObject *parent) : QObject(parent)
{

}

void LecturesController_c::lectureCreation(QQuickTextDocument *_lecture)
{
        qDebug() << ( _lecture->textDocument()->isEmpty() ? "Lecture is empty" : "Lecture is not empty");

        NetworkModel_c::instance()->sendToAll(_lecture->textDocument()->toHtml());
}
