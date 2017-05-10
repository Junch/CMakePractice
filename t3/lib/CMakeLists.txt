// https://argcv.com/articles/3079.c
// https://cmake.org/Wiki/CMake_RPATH_handling

set(CMAKE_MACOSX_RPATH 1)

SET(LIBHELLO_SRC hello.c)
ADD_LIBRARY(hello SHARED ${LIBHELLO_SRC})
ADD_LIBRARY(hello_static STATIC ${LIBHELLO_SRC})

SET_TARGET_PROPERTIES(hello_static PROPERTIES OUTPUT_NAME "hello")
SET_TARGET_PROPERTIES(hello PROPERTIES VERSION 1.2 SOVERSION 1)

INSTALL(TARGETS hello hello_static
        LIBRARY DESTINATION lib   // for dynamic library
        ARCHIVE DESTINATION lib)  // for static library
INSTALL(FILES hello.h DESTINATION include/hello)

# the install RPATH for hello to find exec in the install tree.
# if the install RPATH is not provided, the install bar will have none
set_target_properties(hello PROPERTIES INSTALL_RPATH "@loader_path/../lib")
