#include "registrationview.h"
#include "ui_registrationview.h"

RegistrationView::RegistrationView(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::RegistrationView)
{
    ui->setupUi(this);
}

RegistrationView::~RegistrationView()
{
    delete ui;
}
