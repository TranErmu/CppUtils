cmake_minimum_required(VERSION 3.0)

# set proj
project(Exec VERSION 1.0)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# add cmake scripts
set(INCLUDE_CAMKES 
    ${PROJECT_SOURCE_DIR}/cmake/AutoSearch.cmake
    ${PROJECT_SOURCE_DIR}/cmake/ColorLog.cmake
    )
foreach(cmake ${INCLUDE_CAMKES})
    include(${cmake})
endforeach()

# set language standard
set(CMAKE_C_STANDARD   11)
set(CMAKE_CXX_STANDARD 11)

# set install prefix
set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/output)

# add headers dir
FIND_INCLUDE_DIR(INCLUDES ${PROJECT_SOURCE_DIR})
include_directories(${INCLUDES})

link_directories(${PROJECT_SOURCE_DIR}/lib)

LOG_INFO("include directories:")
foreach(dir ${INCLUDES})
        message(STATUS ${dir})
endforeach()

# add_subdirectory(${PROJECT_SOURCE_DIR}/src/practise/test)

