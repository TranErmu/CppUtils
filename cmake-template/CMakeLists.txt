cmake_minimum_required(VERSION 3.0)

# set proj
project(DEMO VERSION 1.0)

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

set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/output)

# add headers dir
FIND_INCLUDE_DIR(INCLUDES ${PROJECT_SOURCE_DIR})
include_directories(${INCLUDES})

link_directories(${PROJECT_SOURCE_DIR}/lib)

LOG_INFO("include directories:")
foreach(dir ${INCLUDES})
        message(STATUS ${dir})
endforeach()

# add sub dir
# add_subdirectory(${PROJECT_SOURCE_DIR}/src)

############################################################
# 以下可放在子脚本中，根据实际修改

# add source code
set(SRC_DIR 
    ${PROJECT_SOURCE_DIR}/src/
    # ${PROJECT_SOURCE_DIR}/src/compressString
    )
FIND_SRC_FILE(SRCS ${SRC_DIR})

LOG_INFO("source files:")
foreach(file ${SRCS})
        message(STATUS ${file})
endforeach()

# target_link_libraries()

add_executable(${PROJECT_NAME} ${SRCS})
install(TARGETS ${PROJECT_NAME}
        LIBRARY DESTINATION lib             # 动态库安装路径
        ARCHIVE DESTINATION lib             # 静态库安装路径
        RUNTIME DESTINATION bin             # 可执行文件安装路径
        PUBLIC_HEADER DESTINATION include   # 头文件安装路径
        )
# target_include_directories(${PROJ_NAME} PUBLIC include)
