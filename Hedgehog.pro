######################################################################
# Automatically generated by qmake (3.1) Fri Oct 11 13:40:54 2024
######################################################################

TEMPLATE = app
TARGET = Hedgehog
INCLUDEPATH += .
DESTDIR = ./build

CONFIG += c++11

QT += core gui qml widgets
QT += webengine

DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

username = $$system(whoami)

# Input

QMAKE_CXXFLAGS += -g

SOURCES += src/main.cpp \
           src/highlighter.cpp \
           src/documenthandler.cpp

HEADERS += includes/highlighter.h \
           includes/documenthandler.h 

RESOURCES += resources.qrc

# Output Directories
unix:!macx {
    target.path = /home/$$username/Hedgehog
    resources.path = /home/$$username/Hedgehog
    INSTALLS += target resources

    QMAKE_POST_LINK +=  if [ ! -d /home/$$username/Hedgehog ]; then mkdir -p /home/$$username/Hedgehog; fi; \
                        if [ ! -f /home/$$username/Hedgehog/sessionData.json ]; then cp $$PWD/sessionData.json /home/$$username/Hedgehog/; fi; \
                        if [ -f build/Hedgehog ]; then cp build/Hedgehog /home/$$username/Hedgehog/; fi
}

macx {
    target.path = /Applications/Hedgehog
    resources.path = /Applications/Hedgehog
    INSTALLS += target resources

    QMAKE_POST_LINK +=  if [ ! -d /Applications/Hedgehog ]; then mkdir -p /Applications/Hedgehog; fi; \
                        if [ ! -f /Applications/Hedgehog/sessionData.json ]; then cp $$PWD/sessionData.json /Applications/Hedgehog/; fi; \
                        if [ -f build/Hedgehog ]; then cp build/Hedgehog /Applications/Hedgehog/; fi
}

win32 {
    # Set installation paths for Windows
    target.path = $$[QT_INSTALL_PREFIX]/Hedgehog
    resources.path = $$[QT_INSTALL_PREFIX]/Hedgehog
    INSTALLS += target resources

    # Use copy command for Windows
    QMAKE_POST_LINK += if not exist $$[QT_INSTALL_PREFIX]\\Hedgehog mkdir $$[QT_INSTALL_PREFIX]\\Hedgehog & \
                       if not exist $$[QT_INSTALL_PREFIX]\\Hedgehog\\sessionData.json copy /Y sessionData.json $$[QT_INSTALL_PREFIX]\\Hedgehog & \
                       if exist build/Hedgehog.exe copy /Y build/Hedgehog.exe $$[QT_INSTALL_PREFIX]\\Hedgehog
}
