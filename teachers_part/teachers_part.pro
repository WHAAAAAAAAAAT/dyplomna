QT += quick qml quick quickcontrols2 widgets network websockets

CONFIG += c++17

SOURCES += \
        lecturescontroller_c.cpp \
        logincontroller_c.cpp \
        loginverificationmodel_c.cpp \
        main.cpp \
        networkmodel_c.cpp \
        documenthandler.cpp \
        teacherinfomodel_c.cpp \
        verificationmodel_c.cpp

HEADERS += \
    lecturescontroller_c.h \
    logincontroller_c.h \
    loginverificationmodel_c.h \
    networkmodel_c.h \
    documenthandler.h \
    teacherinfomodel_c.h \
    verificationmodel_c.h

RESOURCES += \
    qml.qrc \
    secure.qrc

include($${_PRO_FILE_PWD_}/../Common/common.pri)

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
