cmake_minimum_required (VERSION 3.12)

project (HELLO)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMakeModules ${CMAKE_MODULE_PATH})
include(sanitizers)

set(CMAKE_BUILD_TYPE Debug)
set(SRC_LIST main.cpp)
add_executable(hello ${SRC_LIST})

target_link_libraries(hello PRIVATE sanitizers)

set_target_properties(hello PROPERTIES 
  CXX_STANDARD 11
  CXX_STANDARD_PROPERTIES YES
  CXX_EXTENSIONS NO)

sanitizers_target_properties(hello)
