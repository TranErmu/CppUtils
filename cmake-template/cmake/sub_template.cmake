# set target name
get_filename_component(dir_name ${CMAKE_CURRENT_LIST_DIR} NAME)
set (PRESENT_TARGET ${dir_name})

# add source code
set(SRC_DIR ${CMAKE_CURRENT_LIST_DIR})
FIND_SRC_FILE(SRCS ${SRC_DIR})

LOG_INFO("source files:")
foreach(file ${SRCS})
        message(STATUS ${file})
endforeach()


add_executable(${PRESENT_TARGET} ${SRCS})

# target_link_libraries()
# target_include_directories(${PROJ_NAME} PUBLIC include)

install(TARGETS ${PRESENT_TARGET}
        LIBRARY DESTINATION ${PRESENT_TARGET}                   # 动态库安装路径
        ARCHIVE DESTINATION ${PRESENT_TARGET}                   # 静态库安装路径
        RUNTIME DESTINATION ${PRESENT_TARGET}                   # 可执行文件安装路径
        PUBLIC_HEADER DESTINATION ${PRESENT_TARGET}/include/    # 头文件安装路径
        )
