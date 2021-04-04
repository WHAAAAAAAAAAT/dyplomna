QT += quick qml quick quickcontrols2 widgets

CONFIG += c++17

SOURCES += \
        logincontroller_c.cpp \
        loginverificationmodel_c.cpp \
        main.cpp \
        userinfomodel_c.cpp \
        documenthandler.cpp

RESOURCES += \
    qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    logincontroller_c.h \
    loginverificationmodel_c.h \
    userinfomodel_c.h \
    documenthandler.h
