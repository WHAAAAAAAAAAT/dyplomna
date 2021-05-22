QT += quick qml quick quickcontrols2 widgets network websockets

CONFIG += c++17

SOURCES += \
        courselistmodel_c.cpp \
        jsonconverter.cpp \
        lecturescontroller_c.cpp \
        testcontroller_c.cpp \
        logincontroller_c.cpp \
        main.cpp \
        networkmodel_c.cpp \
        documenthandler.cpp \
        notificationmodel_c.cpp \
        teacherinfomodel_c.cpp \
        testcreator/testlist.cpp \
        testcreator/testmodel.cpp

HEADERS += \
    courselistmodel_c.h \
    jsonconverter.h \
    lecturescontroller_c.h \
    testcontroller_c.h \
    logincontroller_c.h \
    networkmodel_c.h \
    documenthandler.h \
    notificationmodel_c.h \
    teacherinfomodel_c.h \
    testcreator/testlist.h \
    testcreator/testmodel.h

RESOURCES += qml.qrc \
    ../teachers_part/UI/chat/shared/shared.qrc

include($${_PRO_FILE_PWD_}/../Common/common.pri)

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
