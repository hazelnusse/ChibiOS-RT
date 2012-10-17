
# gcc ARMCMx common
include(${CHIBIOS_CMAKE_DIR}/ports/gcc/armcmx.cmake)

# source files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32F4xx/cmparams.h
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32F4xx/vectors.c
)
include_directories(
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32F4xx
)

# set the type of CPU
set(CPU_FLAGS "-mcpu=cortex-m4 -mthumb")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CPU_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CPU_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${CPU_FLAGS} -nostartfiles")

# set the linker script
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32F4xx/ld/STM32F407xG.ld")

# option to use the hardware FPU
option(CHIBIOS_USE_HARDWARE_FPU "Use hardware FPU" TRUE)
if(CHIBIOS_USE_HARDWARE_FPU)
    add_definitions("-DCORTEX_USE_FPU=TRUE")
    set(FPU_FLAGS "-mfloat-abi=softfp -mfpu=fpv4-sp-d16 -fsingle-precision-constant")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FPU_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FPU_FLAGS}")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${FPU_FLAGS}")
else()
    add_definitions("-DCORTEX_USE_FPU=FALSE")
endif()
