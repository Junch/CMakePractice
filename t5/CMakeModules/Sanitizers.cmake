option(sanitizer.asan "Enable address sanitizer" ON)
option(sanitizer.ubsan "Enable undefined behavior sanitizer" OFF)
option(sanitizer.tsan "Enable thread sanitizer" OFF)
option(sanitizer.msan "Enable memory sanitizer" OFF)
option(sanitizer.recovery "Continue on failure" ON)

if(sanitizer.asan OR sanitizer.ubsan OR sanitizer.tsan OR sanitizer.msan)
  set(sanitizer.frame_pointer ON CACHE INTERNAL "")
endif()

add_library(sanitizers INTERFACE)
target_compile_options(sanitizers INTERFACE
  $<$<BOOL:${sanitizer.asan}>:-fsanitize=address>
  $<$<BOOL:${sanitizer.ubsan}>:-fsanitize=undefined>
  $<$<BOOL:${sanitizer.tsan}>:-fsanitize=thread>
  $<$<BOOL:${sanitizer.msan}>:-fsanitize=memory>
  $<$<BOOL:${sanitizer.frame_pointer}>:-fno-omit-frame-pointer>
  $<$<NOT:$<BOOL:${sanitizer.recovery}>>:-fno-sanitize-recover=all>
)

function(sanitizers_target_properties _target)
  if (sanitizer.asan)
    #set_target_properties(${_target} PROPERTIES LINK_FLAGS "${LINK_FLAGS} -fsanitize=address")
    set_property(TARGET ${_target} APPEND_STRING PROPERTY LINK_FLAGS " -fsanitize=address")
  endif()

  if (sanitizer.ubsan)
    set_property(TARGET ${_target} APPEND_STRING PROPERTY LINK_FLAGS " -fsanitize=undefined")
  endif()

  if (sanitizer.tsan)
    set_property(TARGET ${_target} APPEND_STRING PROPERTY LINK_FLAGS " -fsanitize=thread")
  endif()

  if (sanitizer.msan)
    set_property(TARGET ${_target} APPEND_STRING PROPERTY LINK_FLAGS " -fsanitize=memory")
  endif()
endfunction()

# https://www.reddit.com/r/cpp/comments/7qzqlg/dev_santa_claus_pt1_adding_clang_sanitizers_to_a/
# https://www.reddit.com/r/learnprogramming/comments/8pyeam/suggestions_for_c_memory_leak_detector_on_high/
# https://lemire.me/blog/2016/04/20/no-more-leaks-with-sanitize-flags-in-gcc-and-clang/
# https://clang.llvm.org/docs/UsersManual.html#controlling-code-generation