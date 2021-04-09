cmake_minimum_required(VERSION 3.5)

project(qml-playground LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(Qt5 COMPONENTS Core Quick Positioning Location Multimedia REQUIRED)

if(ANDROID)
    add_library(qml-playground SHARED
      main.cpp
      AudioLevels.cpp
      qml.qrc
      img.qrc
      music.qrc
    )
else()
    add_executable(qml-playground
      main.cpp
      AudioLevels.cpp
      qml.qrc
      img.qrc
      music.qrc
    )
endif()

target_compile_definitions(qml-playground
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(qml-playground
  PRIVATE Qt5::Core Qt5::Quick Qt5::Positioning Qt5::Location Qt5::Multimedia)
