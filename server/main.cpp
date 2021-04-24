#include <QCoreApplication>

#include "networkmodel_c.h"
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    auto server = NetworkModel_c::instance();
    Q_UNUSED(server);
    return a.exec();
}
