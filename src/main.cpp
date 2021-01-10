#include "mainwindow.h"
#include "registrationview.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    RegistrationView w;
    w.show();
    return a.exec();
}
