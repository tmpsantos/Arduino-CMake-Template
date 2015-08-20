# This file is based on the work of:
#
# http://mjo.tc/atelier/2009/02/arduino-cli.html
# http://johanneshoff.com/arduino-command-line.html
# http://www.arduino.cc/playground/Code/CmakeBuild
# http://www.tmpsantos.com.br/en/2010/12/arduino-uno-ubuntu-cmake/
# http://forum.arduino.cc/index.php?topic=244741.0


set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_C_COMPILER avr-gcc)
set(CMAKE_CXX_COMPILER avr-g++)
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")
enable_language(ASM)

# C only fine tunning
set(TUNNING_FLAGS "-funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums") 

set(CMAKE_CXX_FLAGS "-mmcu=${ARDUINO_MCU} -DF_CPU=${ARDUINO_FCPU} -Os")
set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} ${TUNNING_FLAGS} -Wall -Wstrict-prototypes -std=gnu99")

set(ARDUINO_CORE_DIR "${ARDUINO_ROOT}/hardware/arduino/avr/cores/arduino/")
set(ARDUINO_PINS_DIR "${ARDUINO_ROOT}/hardware/arduino/avr/variants/${ARDUINO_BOARD}")
set(ARDUINO_PINS_DIR "${ARDUINO_ROOT}/hardware/arduino/avr/variants/${ARDUINO_BOARD}")
set(AVRDUDE_CONFIG "${ARDUINO_ROOT}/hardware/tools/avr/etc/avrdude.conf")

include_directories(${ARDUINO_PINS_DIR})
include_directories(${ARDUINO_CORE_DIR})

set(ARDUINO_SOURCE_FILES
	${ARDUINO_CORE_DIR}/wiring_pulse.S
	${ARDUINO_CORE_DIR}/wiring_digital.c
	${ARDUINO_CORE_DIR}/wiring.c
	${ARDUINO_CORE_DIR}/WInterrupts.c
	${ARDUINO_CORE_DIR}/wiring_pulse.c
	${ARDUINO_CORE_DIR}/wiring_shift.c
	${ARDUINO_CORE_DIR}/hooks.c 
	${ARDUINO_CORE_DIR}/wiring_analog.c
	${ARDUINO_CORE_DIR}/WMath.cpp
	${ARDUINO_CORE_DIR}/IPAddress.cpp
	${ARDUINO_CORE_DIR}/Tone.cpp
	${ARDUINO_CORE_DIR}/HardwareSerial2.cpp
	${ARDUINO_CORE_DIR}/HID.cpp
	${ARDUINO_CORE_DIR}/Print.cpp
	${ARDUINO_CORE_DIR}/new.cpp
	${ARDUINO_CORE_DIR}/HardwareSerial0.cpp
	${ARDUINO_CORE_DIR}/HardwareSerial.cpp
	${ARDUINO_CORE_DIR}/WString.cpp
	${ARDUINO_CORE_DIR}/abi.cpp
	${ARDUINO_CORE_DIR}/USBCore.cpp
	${ARDUINO_CORE_DIR}/Stream.cpp
	${ARDUINO_CORE_DIR}/CDC.cpp
)

set(PORT $ENV{ARDUINO_PORT})
if (NOT PORT)
    set(PORT ${ARDUINO_PORT})
endif()

find_program(AVROBJCOPY "avr-objcopy")
find_program(AVRDUDE "avrdude")

# FIXME: Forcing target name to be "firmware"
if(AVROBJCOPY AND AVRDUDE)
    add_custom_target(hex)
    add_dependencies(hex firmware)

    add_custom_command(TARGET hex POST_BUILD
        COMMAND ${AVROBJCOPY} -O ihex -R .eeprom ${CMAKE_CURRENT_BINARY_DIR}/firmware firmware.hex
    )

    add_custom_target(flash)
    add_dependencies(flash hex)

    add_custom_command(TARGET flash POST_BUILD
        COMMAND ${AVRDUDE} -C${AVRDUDE_CONFIG} -v -p${ARDUINO_MCU} -c${ARDUINO_PROTOCOL}  -P${PORT} -b${ARDUINO_UPLOAD_SPEED} -D -Uflash:w:firmware.hex:i
    )
endif()

add_custom_target(reset)
add_custom_command(TARGET reset POST_BUILD
    COMMAND echo 0 > ${PORT}
)
