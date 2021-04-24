#include <QCoreApplication>

#include "networkmodel_c.h"
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    NetworkModel_c::instance();
    return a.exec();
}
