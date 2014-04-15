#-------------------------------------------------
#
# Redis Desktop Manager
#
#-------------------------------------------------

QT       += core gui network xml concurrent

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = rdm
TEMPLATE = app

CONFIG -= debug
CONFIG += release


#CONFIG-=app_bundle

SOURCES += \
    $$PWD/source/main.cpp \
    $$PWD/source/application.cpp \
    $$PWD/source/connection.cpp \
    $$PWD/source/widgets/*.cpp \
    $$PWD/source/crashhandler/*.cpp \
    $$PWD/source/updater/Updater.cpp \
    $$PWD/source/redis/*.cpp \
    $$PWD/source/network/*.cpp \
    $$PWD/source/models/*.cpp \
    $$PWD/source/models/items/*.cpp \
    $$PWD/source/models/value-view-formatters/*.cpp \

HEADERS  += \
    $$PWD/version.h \
    $$PWD/include/*.h \
    $$PWD/include/widgets/*.h \
    $$PWD/include/crashhandler/*.h \
    $$PWD/include/updater/Updater.h \
    $$PWD/include/redis/*.h \
    $$PWD/include/network/*.h \
    $$PWD/include/models/*.h \
    $$PWD/include/models/items/*.h \
    $$PWD/include/models/value-view-formatters/*.h \


release: DESTDIR = ./../bin/linux/release
debug:   DESTDIR = ./../bin/linux/debug

OBJECTS_DIR = $$DESTDIR/.obj
MOC_DIR = $$DESTDIR/.moc
RCC_DIR = $$DESTDIR/.qrc
UI_DIR = $$DESTDIR/.ui

BREAKPADDIR = $$PWD/../deps/google-breakpad/src

win32 {
    CONFIG += c++11
    LIBS += -lws2_32 -lkernel32 -luser32 -lshell32 -luuid -lole32 -ladvapi32

    CONFIG(release, debug|release) {
        LIBS += -L$$PWD/../deps/libs/win32/release/ -llibssh2
        PRE_TARGETDEPS += $$PWD/../deps/libs/win32/release/libssh2.lib
    }

    else: CONFIG(debug, debug|release) {
        LIBS += -L$$PWD/../deps/libs/win32/debug/ -llibssh2
        PRE_TARGETDEPS += $$PWD/../deps/libs/win32/debug/libssh2.lib
    }
}

unix {
    macx { # os x 10.8
        CONFIG += c++11

        LIBS += /usr/local/lib/libssh2.dylib
        LIBS += $$BREAKPADDIR/client/mac/build/Release/Breakpad.framework/Versions/A/Breakpad
        PRE_TARGETDEPS += /usr/local/lib/libssh2.dylib  $$BREAKPADDIR/client/mac/build/Release/Breakpad.framework

        INCLUDEPATH += $$PWD/../deps/libssh/include

        QMAKE_INFO_PLIST = Info.plist
        ICON = rdm.icns

        INCLUDEPATH += $$BREAKPADDIR/ \
                        $$BREAKPADDIR/client/mac/handler/ \
                        $$BREAKPADDIR/client/mac/ \
                        $$BREAKPADDIR/client/ \
                        $$BREAKPADDIR/client/mac/crash_generation/ \
                        $$BREAKPADDIR/common/mac/ \
                        $$BREAKPADDIR/common/linux/ \
                        $$BREAKPADDIR/common/ \
                        $$BREAKPADDIR/processor/ \
                        $$BREAKPADDIR/google_breakpad/common/ \
                        $$BREAKPADDIR/third_party/lss/ \

        LIBS += /System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation
        LIBS += /System/Library/Frameworks/CoreServices.framework/Versions/A/CoreServices

        #breakpad app need debug info inside binaries
        QMAKE_CXXFLAGS+=-g

        APP_DATA_FILES.files = $$BREAKPADDIR/client/mac/build/Release/Breakpad.framework
        APP_DATA_FILES.path = Contents/Frameworks
        QMAKE_BUNDLE_DATA += APP_DATA_FILES

        CRASHREPORTER_APP.files = $$DESTDIR/crashreporter
        CRASHREPORTER_APP.path = Contents/MacOS
        QMAKE_BUNDLE_DATA += CRASHREPORTER_APP

    }
    else {
        QMAKE_CXXFLAGS += -std=c++11
        LIBS += -lssh2
    }
}

INCLUDEPATH += $$PWD/../deps/libssh/include
DEPENDPATH += $$PWD/../deps/libssh/include
DEPENDPATH += $$BREAKPADDIR

INCLUDEPATH += $$PWD/source \
    $$PWD/source/models \
    $$PWD/source/models/items \
    $$PWD/source/network \
    $$PWD/source/redis \
    $$PWD/source/updater \
    $$PWD/source/widgets \
    $$PWD/"include" \
    $$PWD/include/models \
    $$PWD/include/models/items \
    $$PWD/include/models/value-view-formatters \
    $$PWD/include/network \
    $$PWD/include/redis \
    $$PWD/include/updater \
    $$PWD/include/crashhandler \
    $$PWD/include/widgets \

FORMS += \
    $$PWD/forms/*.ui \

RESOURCES += \
    Resources/demo.qrc

OTHER_FILES += \
    qt.conf \
    Info.plist


