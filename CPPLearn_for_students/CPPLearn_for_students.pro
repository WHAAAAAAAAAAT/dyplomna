QT += quick qml quickcontrols2 widgets network websockets charts

CONFIG += c++17

SOURCES += \
        chartconverter.cpp \
        chartmodel_c.cpp \
        courselistmodel_c.cpp \
        jsonconverter.cpp \
        lecturecontroller_c.cpp \
        logincontroller_c.cpp \
        main.cpp \
        networkmodel_c.cpp \
        notificationmodel_c.cpp \
        recommendationlistmodel_c.cpp \
        searchhightlight.cpp \
        testcontroller_c.cpp \
        testlist.cpp \
        testmodel.cpp \
        userinfomodel_c.cpp \
        documenthandler.cpp

HEADERS += \
    chartconverter.h \
    chartmodel_c.h \
    courselistmodel_c.h \
    jsonconverter.h \
    lecturecontroller_c.h \
    logincontroller_c.h \
    networkmodel_c.h \
    notificationmodel_c.h \
    recommendationlistmodel_c.h \
    searchhightlight.h \
    testcontroller_c.h \
    testlist.h \
    testmodel.h \
    userinfomodel_c.h \
    documenthandler.h

RESOURCES += qml.qrc \
    ../CPPLearn_for_students/UI/chat/shared/shared.qrc

include($${_PRO_FILE_PWD_}/../Common/common.pri)

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
