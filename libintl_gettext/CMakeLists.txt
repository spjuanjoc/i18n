cmake_minimum_required(VERSION 3.19)

project(libintl_gettext VERSION "0.0.2" LANGUAGES CXX)

set(SOURCE_FILES main.cpp)
add_executable(${PROJECT_NAME} ${SOURCE_FILES})


set(PROJECT_OPTIONS
  -O2
  -Wpedantic
  -Wall
  -Wextra
  -Werror
)


## Setup Conan
if (NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
  message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD
      "https://raw.githubusercontent.com/conan-io/cmake-conan/master/conan.cmake"
      "${CMAKE_BINARY_DIR}/conan.cmake"
      )
endif ()

include(${CMAKE_BINARY_DIR}/conan.cmake)
conan_check(REQUIRED)
conan_cmake_autodetect(settings)
conan_cmake_run(CONANFILE ../conanfile.txt BASIC_SETUP NO_OUTPUT_DIRS SETTINGS ${settings})


## Find third-party packages
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_BINARY_DIR})
find_package(fmt REQUIRED)
find_package(gettext REQUIRED)


## Target
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)
target_compile_options(${PROJECT_NAME} INTERFACE ${PROJECT_OPTIONS})


if (gettext_FOUND)
  message(STATUS "gettext found")
  include(cmake/gettext.cmake)
  set (LOCALE_DIR ${CMAKE_BINARY_DIR}/locale/es/LC_MESSAGES)
  file(MAKE_DIRECTORY ${LOCALE_DIR})
  set(POT_FILE ${LOCALE_DIR}/main.pot)
  run_xgettext(${SOURCE_FILES} ${POT_FILE})
  message(STATUS "POT file created: ${POT_FILE}")
else()
  message(STATUS "gettext NOT found")
endif ()
