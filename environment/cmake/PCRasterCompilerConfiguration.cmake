set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# On Linux/macOS we set the RPATH for our libraries/executables
# From the CMake wiki:

# use, i.e. don't skip the full RPATH for the build tree
set(CMAKE_SKIP_BUILD_RPATH  OFF)

# when building, don't use the install RPATH already
# (but later on when installing)
set(CMAKE_BUILD_WITH_INSTALL_RPATH OFF)

# the RPATH to be used when installing
set(CMAKE_INSTALL_RPATH "\\\$ORIGIN/../lib")

# don't add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH OFF)


# Default flags without toolchain files
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

if(${CMAKE_BUILD_TYPE} STREQUAL "Release")

    add_compile_options(
        "$<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-march=native;-mtune=native>"
    )

    include(CheckIPOSupported)
    check_ipo_supported(RESULT ipo_available)
    if(ipo_available)
      set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
      set(CMAKE_AR ${CMAKE_CXX_COMPILER_AR})
      set(CMAKE_RANLIB ${CMAKE_CXX_COMPILER_RANLIB})
    endif()


endif()





# In general, don't set compiler options in CMake files. Here we set the
# most general options that everybody always wants. Anything else should
# be handled from the outside.
# Not yet (treat warnings as errors):
#   MSVC: /WX
#   GNU/Clang: -Werror
# add_compile_options(
#     "$<$<CXX_COMPILER_ID:MSVC>:/W3 /WX>"
#     "$<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-W -Wall>"
# )






# TODO Get rid of these...
set(CMAKE_CXX_FLAGS_DEBUG
    "${CMAKE_CXX_FLAGS_DEBUG} -DDEBUG -DDEBUG_BUILD -DDEBUG_DEVELOP"
)
set(CMAKE_C_FLAGS_DEBUG
    "${CMAKE_C_FLAGS_DEBUG} -DDEBUG -DDEBUG_BUILD -DDEBUG_DEVELOP"
)

