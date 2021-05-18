INCLUDEPATH += $$PWD

QT += sql

HEADERS += \
    $$PWD/chat/sqlcontactmodel.h \
    $$PWD/chat/sqlconversationmodel.h \
    $$PWD/commondata.h \
    $$PWD/courseitem.h \
    $$PWD/jsontypes.h \
    $$PWD/lecture.h \
    $$PWD/networkmessages.h \
    $$PWD/testitem.h \
    $$PWD/user.h


SOURCES += \
    $$PWD/chat/sqlcontactmodel.cpp \
    $$PWD/chat/sqlconversationmodel.cpp \
    $$PWD/commondata.cpp \
    $$PWD/lecture.cpp \
    $$PWD/user.cpp
