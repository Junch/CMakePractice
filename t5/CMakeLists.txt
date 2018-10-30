cmake_minimum_required (VERSION 3.12)

project (HELLO)

option(sanitizer.asan "Enable address sanitizer" ON)
option(sanitizer.ubsan "Enable undefined behavior sanitizer" OFF)
option(sanitizer.tsan "Enable thread sanitizer" OFF)
option(sanitizer.msan "Enable memory sanitizer" OFF)
option(sanitizer.recovery "Continue on failure" ON)

if(sanitizer.asan OR sanitizer.ubsan OR sanitizer.tsan OR sanitizer.msan)
  set(sanitizer.frame_pointer ON CACHE INTERNAL "")
endif()

set(CMAKE_BUILD_TYPE Debug)
set(SRC_LIST main.cpp)
add_executable(hello ${SRC_LIST})

target_compile_options(hello PRIVATE
  $<$<BOOL:${sanitizer.asan}>:-fsanitize=address>
  $<$<BOOL:${sanitizer.ubsan}>:-fsanitize=undefined>
  $<$<BOOL:${sanitizer.tsan}>:-fsanitize=thread>
  $<$<BOOL:${sanitizer.msan}>:-fsanitize=memory>
  $<$<BOOL:${sanitizer.frame_pointer}>:-fno-omit-frame-pointer>
  $<$<BOOL:${sanitizer.frame_pointer}>:-O1>
  $<$<NOT:$<BOOL:${sanitizer.recovery}>>:-fno-sanitize-recover=all>
)

set_target_properties(hello PROPERTIES 
  CXX_STANDARD 11
  CXX_STANDARD_PROPERTIES YES
  CXX_EXTENSIONS NO)

if (sanitizer.frame_pointer)
    set_target_properties(hello PROPERTIES LINK_FLAGS "${LINK_FLAGS} -fno-omit-frame-pointer")
endif()

if (sanitizer.asan)
    set_target_properties(hello PROPERTIES LINK_FLAGS "${LINK_FLAGS} -fsanitize=address")
endif()

if (sanitizer.ubsan)
    set_target_properties(hello PROPERTIES LINK_FLAGS "${LINK_FLAGS} -fsanitize=undefined")
endif()

if (sanitizer.tsan)
    set_target_properties(hello PROPERTIES LINK_FLAGS "${LINK_FLAGS} -fsanitize=thread")
endif()

if (sanitizer.msan)
    set_target_properties(hello PROPERTIES LINK_FLAGS "${LINK_FLAGS} -fsanitize=memory")
endif()

# https://www.reddit.com/r/learnprogramming/comments/8pyeam/suggestions_for_c_memory_leak_detector_on_high/
# https://lemire.me/blog/2016/04/20/no-more-leaks-with-sanitize-flags-in-gcc-and-clang/
# https://clang.llvm.org/docs/UsersManual.html#controlling-code-generation