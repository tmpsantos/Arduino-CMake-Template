project(MYPROJECT)

cmake_minimum_required(VERSION 2.6)

# Change this to the directory of your Arduino installation.
# On a Mac, it will be something like '/Applications/Arduino.app/Contents/Java'
set(ARDUINO_ROOT "$ENV{HOME}/opt/arduino")

include(${CMAKE_SOURCE_DIR}/cmake/arduino_uno.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/arduino-1.6.cmake)

set(MYPROJECT_SOURCE_FILES
    ${CMAKE_SOURCE_DIR}/src/main.cpp
    ${ARDUINO_SOURCE_FILES}
)

add_executable(firmware ${MYPROJECT_SOURCE_FILES})