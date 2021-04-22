#include "lecturescontroller_c.h"

#include "documenthandler.h"

LecturesController_c::LecturesController_c(QObject *parent) : QObject(parent)
{

}

void LecturesController_c::lectureCreation(const QTextDocument &_lecture)
{
    if(!_lecture.isEmpty()) {
        qDebug() << "Lecture is not empty";
    }
    else {
        qDebug() << "Lecture is empty";
    }
    /*if(LoginVerificationModel_c::instance()->loginVerificationSuccessful(_username, _password))
    {
        TeacherInfoModel_c::instance()->setUsername(_username);
        TeacherInfoModel_c::instance()->setPassword(_password);
        emit lectureSendingSuccess();
    }
    else
    {
        emit lectureSendingError();
    }*/

}
