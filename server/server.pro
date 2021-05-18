QT -= gui
QT += network websockets

CONFIG += c++17 console
CONFIG -= app_bundle

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        coursefoldermodel.cpp \
        lecturefilemodel_c.cpp \
        main.cpp \
        networkmodel_c.cpp \
        testfilemodel_c.cpp \
        verificationmodel_c.cpp \
        loginverificationmodel_c.cpp

HEADERS += \
        coursefoldermodel.h \
        lecturefilemodel_c.h \
        networkmodel_c.h \
        testfilemodel_c.h \
        verificationmodel_c.h \
        loginverificationmodel_c.h

RESOURCES += \
    secure.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

include($${_PRO_FILE_PWD_}/../Common/common.pri)
