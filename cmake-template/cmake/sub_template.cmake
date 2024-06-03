# set target name
# default is the current folder name
get_filename_component(DIR_NAME ${CMAKE_CURRENT_LIST_DIR} NAME)
set (PRESENT_TARGET ${DIR_NAME})

# add source code
set(SRC_DIR ${CMAKE_CURRENT_LIST_DIR})
FIND_SRC_FILE(SRCS ${SRC_DIR})

LOG_INFO("source files:")
foreach(file ${SRCS})
        message(STATUS ${file})
endforeach()

add_executable(${PRESENT_TARGET} ${SRCS})
# add_library()

# target_link_libraries()
# target_include_directories(${PROJ_NAME} PUBLIC include)

install(TARGETS ${PRESENT_TARGET}
        LIBRARY DESTINATION ${PRESENT_TARGET}                   # 动态库安装路径
        ARCHIVE DESTINATION ${PRESENT_TARGET}                   # 静态库安装路径
        RUNTIME DESTINATION ${PRESENT_TARGET}                   # 可执行文件安装路径
        PUBLIC_HEADER DESTINATION ${PRESENT_TARGET}/include/    # 头文件安装路径
        )
