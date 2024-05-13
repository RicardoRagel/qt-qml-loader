QT += widgets qml quick # Others usual: 3dinput positioning svg multimedia gamepad
CONFIG += c++17         # C++ Version
CONFIG += qml_debug     # Enable QML console debug
#CONFIG += resources_big # Set this flag if your resources are big and cause a compilation error

VERSION = 1.0.0         # App version as major.minor.patch
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

INCLUDEPATH += include/Core \
               include/DataLayer
HEADERS += \
    include/Core/App.h \
    include/DataLayer/DataManager.h \
    include/DataLayer/Item.h

SOURCES += \
    src/Core/App.cpp \
    src/DataLayer/DataManager.cpp \
    src/DataLayer/Item.cpp \
    src/main.cpp

OTHER_FILES += \
    qml/main.qml

RESOURCES += \
    app_media.qrc \
    app_qml.qrc
