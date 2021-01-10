#ifndef REGISTRATIONVIEW_H
#define REGISTRATIONVIEW_H

#include <QDialog>

namespace Ui {
class RegistrationView;
}

class RegistrationView : public QDialog
{
    Q_OBJECT

public:
    explicit RegistrationView(QWidget *parent = nullptr);
    ~RegistrationView();

private:
    Ui::RegistrationView *ui;
};

#endif // REGISTRATIONVIEW_H
