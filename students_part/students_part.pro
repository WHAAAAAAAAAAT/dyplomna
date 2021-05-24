QT += quick qml quickcontrols2 widgets network websockets

CONFIG += c++17

SOURCES += \
        courselistmodel_c.cpp \
        jsonconverter.cpp \
        lecturecontroller_c.cpp \
        logincontroller_c.cpp \
        main.cpp \
        networkmodel_c.cpp \
        notificationmodel_c.cpp \
        qcustomplot.cpp \
        recommendationlistmodel_c.cpp \
        searchhightlight.cpp \
        testcontroller_c.cpp \
        testlist.cpp \
        testmodel.cpp \
        userinfomodel_c.cpp \
        documenthandler.cpp

HEADERS += \
    courselistmodel_c.h \
    jsonconverter.h \
    lecturecontroller_c.h \
    logincontroller_c.h \
    networkmodel_c.h \
    notificationmodel_c.h \
    qcustomplot.h \
    recommendationlistmodel_c.h \
    searchhightlight.h \
    testcontroller_c.h \
    testlist.h \
    testmodel.h \
    userinfomodel_c.h \
    documenthandler.h

RESOURCES += qml.qrc \
    ../students_part/UI/chat/shared/shared.qrc

include($${_PRO_FILE_PWD_}/../Common/common.pri)

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
