# ---- Basics ------------------------------------------------------------------
cmake_minimum_required(VERSION 3.16)  # 3.16+ for modern features

project({{_projectname_}} LANGUAGES C CXX)

# Export compile_commands.json (good for clangd, tooling)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Default build type for single-config generators (Makefiles/Ninja)
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# Language standards
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# ---- Output layout -----------------------------------------------------------
# Final runtime/shared go into bin/, static/import go into obj/
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/obj")

# For multi-config (e.g. MSVC, Ninja Multi-Config), add per-config subdirs
if(CMAKE_CONFIGURATION_TYPES)
  foreach(cfg ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER "${cfg}" cfgU)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${cfgU} "${PROJECT_SOURCE_DIR}/bin/${cfg}")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${cfgU} "${PROJECT_SOURCE_DIR}/bin/${cfg}")
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${cfgU} "${PROJECT_SOURCE_DIR}/obj/${cfg}")
  endforeach()
endif()

# ---- Include paths -----------------------------------------------------------
# Public headers live in include/
include_directories("${PROJECT_SOURCE_DIR}/include")

# ---- Sources (C & C++) -------------------------------------------------------
# aux_source_directory() is limited and C-only; use GLOB for C and C++
file(GLOB_RECURSE SRC_C    CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/src/*.c")
file(GLOB_RECURSE SRC_CXX  CONFIGURE_DEPENDS
  "${PROJECT_SOURCE_DIR}/src/*.cc" "${PROJECT_SOURCE_DIR}/src/*.cpp" "${PROJECT_SOURCE_DIR}/src/*.cxx")
set(SRC_LIST ${SRC_C} ${SRC_CXX})

if(SRC_LIST STREQUAL "")
  message(WARNING "No sources found under src/. Add .c/.cc/.cpp files.")
endif()

# ---- Target ------------------------------------------------------------------
# Target name keeps your original 'main.bin'
add_executable(main.bin ${SRC_LIST})

# Basic compile flags per config & compiler
if(MSVC)
  target_compile_options(main.bin PRIVATE /W4 /permissive-)
  if(CMAKE_BUILD_TYPE MATCHES "Debug")
    target_compile_options(main.bin PRIVATE /Zi)
  endif()
else()
  # Common warnings
  target_compile_options(main.bin PRIVATE -Wall -Wextra -Wpedantic -Wformat=2 -Wshadow -Wundef)
  # Debug: more debug info + frame pointers (helps sanitizers, profilers)
  if(CMAKE_BUILD_TYPE MATCHES "Debug")
    target_compile_options(main.bin PRIVATE -g3 -fno-omit-frame-pointer)
    target_link_options(main.bin PRIVATE -fno-omit-frame-pointer)
  endif()
endif()

# Add a couple of handy defines
target_compile_definitions(main.bin PRIVATE
  PROJECT_NAME="${PROJECT_NAME}"
)

# ---- Tooling & hardening toggles --------------------------------------------
# Sanitizers in Debug (non-MSVC)
if(NOT MSVC AND (CMAKE_BUILD_TYPE STREQUAL "Debug" OR CMAKE_CONFIGURATION_TYPES))
  # Use at your discretion; comment out if using valgrind or similar
  target_compile_options(main.bin PRIVATE -fsanitize=address,undefined)
  target_link_options(main.bin PRIVATE -fsanitize=address,undefined)
endif()

# LTO/IPO for Release/RelWithDebInfo when supported
include(CheckIPOSupported)
check_ipo_supported(RESULT _ipo_ok OUTPUT _ipo_msg)
if(_ipo_ok)
  set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)
  set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELWITHDEBINFO ON)
else()
  message(STATUS "IPO/LTO not enabled: ${_ipo_msg}")
endif()

# Threads (POSIX)
find_package(Threads REQUIRED)
target_link_libraries(main.bin PRIVATE Threads::Threads)

# ---- Install (optional) ------------------------------------------------------
include(GNUInstallDirs)
install(TARGETS main.bin
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# ---- Notes -------------------------------------------------------------------
# 1) Object files stay in the build tree (by CMake design). Final binaries/libs
#    are redirected to bin/ and obj/ as requested.
# 2) To override project name if template text stays as 'YourProjectName':
#      cmake -S . -B build -DPROJECT_NAME_OVERRIDE=DLA
