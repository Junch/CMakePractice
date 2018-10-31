cmake_minimum_required (VERSION 3.12)

project (HELLO)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMakeModules ${CMAKE_MODULE_PATH})
include(sanitizers)

# https://arne-mertz.de/2018/07/cmake-properties-options/
if (MSVC)
    # warning level 4 and all warnings as errors
    add_compile_options(/W4 /WX)
else()
    # lots of warnings and all warnings as errors
    add_compile_options(-Wall -Wextra -pedantic -Werror)
endif()

set(CMAKE_BUILD_TYPE Debug)

set(SRC_LIST main.cpp)
add_executable(hello ${SRC_LIST})

set_target_properties(hello PROPERTIES 
  CXX_STANDARD 11
  CXX_STANDARD_PROPERTIES YES
  CXX_EXTENSIONS NO)
