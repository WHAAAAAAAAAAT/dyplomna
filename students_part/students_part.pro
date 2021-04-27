QT += quick qml quickcontrols2 widgets network websockets

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        courselistmodel_c.cpp \
        lecturecontroller_c.cpp \
        logincontroller_c.cpp \
        main.cpp \
        networkmodel_c.cpp \
        notificationmodel_c.cpp \
        userinfomodel_c.cpp \
        documenthandler.cpp

HEADERS += \
    courselistmodel_c.h \
    lecturecontroller_c.h \
    logincontroller_c.h \
    networkmodel_c.h \
    notificationmodel_c.h \
    userinfomodel_c.h \
    documenthandler.h

RESOURCES += qml.qrc \
    ../students_part/UI/chat/shared/shared.qrc

include($${_PRO_FILE_PWD_}/../Common/common.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
