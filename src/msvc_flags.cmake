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

  set(_myflags " /fp:fast /Gw /guard:cf")
  set(CMAKE_C_FLAGS_RELEASE_INIT ${CMAKE_C_FLAGS_RELEASE_INIT} ${_myflags})
  set(CMAKE_CXX_FLAGS_RELEASE_INIT ${CMAKE_CXX_FLAGS_RELEASE_INIT} ${_myflags})

  _cmake_initialize_per_config_variable(${ARGV})
endfunction()
