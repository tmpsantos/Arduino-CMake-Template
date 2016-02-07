project(MYPROJECT)

cmake_minimum_required(VERSION 2.6)

# Change this to the directory of your Arduino installation.
# On a Mac, it will be something like '/Applications/Arduino.app/Contents/Java'
set(ARDUINO_ROOT "$ENV{HOME}/opt/arduino")

# Change this to the serial port your Arduino is attached to.
set(ARDUINO_PORT "/dev/ttyACM1")

# Change this to the Arduino board you are using.
include(${CMAKE_SOURCE_DIR}/cmake/arduino_mega1280.cmake)

include(${CMAKE_SOURCE_DIR}/cmake/arduino-1.6.cmake)


set(MYPROJECT_SOURCE_FILES
    # Add more source files if you need to.
    ${CMAKE_SOURCE_DIR}/src/main.cpp
    ${ARDUINO_SOURCE_FILES}
)

add_executable(firmware ${MYPROJECT_SOURCE_FILES})