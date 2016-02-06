# Arduino-CMake-Template
Starting point for Arduino development using CMake
#Thanks
- http://mjo.tc/atelier/2009/02/arduino-cli.html
- http://johanneshoff.com/arduino-command-line.html
- http://www.arduino.cc/playground/Code/CmakeBuild
- http://www.tmpsantos.com.br/en/2010/12/arduino-uno-ubuntu-cmake/
- http://forum.arduino.cc/index.php?topic=244741.0

#Usage
1. Check the `CMakeList.txt`
  * Update the project name
  * Update include to fit you hardware or create a new cmake/arduino_*.cmake`
  * Update the Arduino installation directory
  
2. Check the included `make/arduino_*.cmake`
  * Basic information for new board configurations can be found i`n the `boards.txt` file from the Arduino installation.
  * Using the original IDE with verbose enabled helps you to tune the command parameters
  
#Updates
##2015-08-20 
Markus Bader
- Works with Arduino IDE 1.6.5
- Tested with Ardunio UNO

##2016-02-06
Matthijs Oosterhoff
- Renamed `scripts` directory to `cmake`.
- Renamed `arduino.cmake` to `arduino-1.6.cmake` to emphasize the compatible version.
- Moved inclusion of `.cmake` files to `CMakeLists.txt`
- Use the compilers and tools provided by the Arduino installation instead of assuming the user has installed them separately.
- Updated the included Arduino sources, because it didn't work.
- Added CMake target to flash using USBasp programmer.
- Moved `ARDUINO_PORT` declaration to `CMakeLists.txt`.
- Added Arduino Mega2560 and Mega1280 configuration.