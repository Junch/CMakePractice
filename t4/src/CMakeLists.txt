INCLUDE_DIRECTORIES(/tmp/t3/include/hello)
#LINK_DIRECTORIES(/tmp/t3/lib)
ADD_EXECUTABLE(main main.c)
TARGET_LINK_LIBRARIES(main /tmp/t3/lib/libhello.a)
