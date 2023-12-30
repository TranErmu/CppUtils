############################################################
# 查找头文件所在的文件夹
macro(FIND_INCLUDE_DIR result root_path)                                        #定义函数,2个参数:存放结果result；指定路径root_path；
    file(GLOB_RECURSE head_files "${root_path}/*.hpp" "${root_path}/*.h" )      #遍历获取{root_path}中*.hpp和*.h文件列表
    set(dirlist "")                                                             #定义dirlist中间变量，并初始化
    foreach(file ${head_files})                                                 #for循环
        string(REGEX REPLACE "(.*)/.*" "\\1" LIB_NAME ${file})                  #字符串替换,用/前的字符替换/*h
        if(IS_DIRECTORY ${LIB_NAME})                                            #判断是否为路径
            list (FIND dirlist ${LIB_NAME} list_index)                          #去重，查找dirlist中是否有${LIB_NAME}指定的值，可以区分字符串相同数子后缀不同的路径：例如/app/test_1和/app/test_2
            if(${list_index} LESS 0)                                            #若没找到则代表列表中没有该路径
                LIST(APPEND dirlist ${LIB_NAME})                                #将合法的路径加入dirlist变量中
            endif()                                                             #结束判断
        endif()
    endforeach()                                                                #结束for循环
    set(${result} ${dirlist})                                                   #dirlist结果放入result变量中
endmacro()

############################################################
# 查找路径下的所有源文件
macro(FIND_SRC_FILE result dir_lists)               #定义函数,2个参数:存放结果result；指定路径dir_lists；
    set(file_lists "")
    foreach(dir ${dir_lists})                       #for循环
        file(GLOB_RECURSE src_file
                "${dir}/*.c"
                "${dir}/*.cpp"
                "${dir}/*.cc"
                "${dir}/*.cxx" )
        list(APPEND file_lists ${src_file})         #遍历获取{dir_lists}中源文件
    endforeach()                                    #结束for循环
    set(${result} ${file_lists})                    #file_lists结果放入result变量中
endmacro()



