# cmake toolchain file that modifies `/MD` to `/MT` on MSVC
# Usage: cmake -DCMAKE_TOOLCHAIN_FILE=/path/to/thisfile.cmake /path/to/src

# cmake_minimum_required(VERSION 3.11)

include_guard(GLOBAL)

include(CMakeInitializeConfigs)

function(cmake_initialize_per_config_variable _PREFIX _DOCSTRING)
  if(_PREFIX MATCHES "CMAKE_(C|CXX)_FLAGS")
    foreach(config
            ${_PREFIX}_DEBUG_INIT
            ${_PREFIX}_RELEASE_INIT
            ${_PREFIX}_RELWITHDEBINFO_INIT
            ${_PREFIX}_MINSIZEREL_INIT)
      string(REPLACE "/MD" "/MT" ${config} "${${config}}")
    endforeach()
  endif()

  set(_mycflags "/fp:fast /GL /guard:cf /Gw")
  set(CMAKE_C_FLAGS_RELEASE_INIT "${CMAKE_C_FLAGS_RELEASE_INIT} ${_mycflags}")
  set(CMAKE_CXX_FLAGS_RELEASE_INIT "${CMAKE_CXX_FLAGS_RELEASE_INIT} ${_mycflags}")

  set(_myldflags "/guard:cf /LTCG /OPT:ICF /OPT:REF")
  set(CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT "${CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT} ${_myldflags}")
  set(CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT "${CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT} ${_myldflags}")
  set(CMAKE_MODULE_LINKER_FLAGS_RELEASE_INIT "${CMAKE_MODULE_LINKER_FLAGS_RELEASE_INIT} ${_myldflags}")

  _cmake_initialize_per_config_variable(${ARGV})
endfunction()

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
