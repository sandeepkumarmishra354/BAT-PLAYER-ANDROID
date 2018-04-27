# allows to add DEPLOYMENTFOLDERS and links to the V-Play library and QtCreator auto-completion
CONFIG += v-play

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the V-Play Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    removefile.cpp \
    mediaextractor.cpp \
    filereader.cpp \
    readthread.cpp

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
    QT += androidextras
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
    
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
    qml/SongList.qml \
    qml/SongPlayerPage.qml \
    qml/AboutPage.qml \
    qml/SongPage.qml \
    qml/AppLogic.js \
    qml/SongOptions.qml \
    qml/SettingPage.qml \
    qml/PlaylistOption.qml \
    qml/PlaylistSongPage.qml \
    qml/SearchList.qml \
    qml/SideBar.qml \
    qml/TimerMenu.qml \
    qml/HourTumbler.qml \
    qml/MinuteTumbler.qml \
    qml/PropertyContainer.qml \
    qml/ThemeLogic.js

RESOURCES +=

HEADERS += \
    removefile.h \
    mediaextractor.h \
    filereader.h \
    readthread.h

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
        /V-PlaySDK/V-Play/android_armv7/lib/libcrypto.so \
        /V-PlaySDK/V-Play/android_armv7/lib/libssl.so
}

android {
    win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../usr/TAG/lib/release/ -ltag
    else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../usr/TAG/lib/debug/ -ltag
    else:unix: LIBS += -L$$PWD/../../usr/TAG/lib/ -ltag

    INCLUDEPATH += $$PWD/../../usr/TAG/include
    DEPENDPATH += $$PWD/../../usr/TAG/include

    win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../../usr/TAG/lib/release/libtag.a
    else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../../usr/TAG/lib/debug/libtag.a
    else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../../usr/TAG/lib/release/tag.lib
    else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../../usr/TAG/lib/debug/tag.lib
    else:unix: PRE_TARGETDEPS += $$PWD/../../usr/TAG/lib/libtag.a
}

unix {
    win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../usr/local/lib/release/ -ltag
    else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../usr/local/lib/debug/ -ltag
    else:unix: LIBS += -L$$PWD/../../usr/local/lib/ -ltag

    INCLUDEPATH += $$PWD/../../usr/local/include
    DEPENDPATH += $$PWD/../../usr/local/include

    win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../../usr/local/lib/release/libtag.a
    else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../../usr/local/lib/debug/libtag.a
    else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../../usr/local/lib/release/tag.lib
    else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../../usr/local/lib/debug/tag.lib
    else:unix: PRE_TARGETDEPS += $$PWD/../../usr/local/lib/libtag.a
}
