############################################################
# 日志信息
string(ASCII 27 Esc)            # equal to `set(Esc "\033")`
set(EndColor    "${Esc}[m")     # 结束颜色输出
# set(ColorBold   "${Esc}[1m")    # 粗体
# set(Red         "${Esc}[31m")
# set(Green       "${Esc}[32m")
# set(Yellow      "${Esc}[33m")
# set(Blue        "${Esc}[34m")
# set(MAGENTA     "${Esc}[35m")
# set(Cyan        "${Esc}[36m")
# set(White       "${Esc}[37m")
set(BoldRed     "${Esc}[1;31m")
set(BoldGreen   "${Esc}[1;32m")
set(BoldYellow  "${Esc}[1;33m")
# set(BOLDBLUE    "${Esc}[1;34m")
# set(BOLDMAGENTA "${Esc}[1;35m")
set(BoldCyan    "${Esc}[1;36m")
# set(BOLDWHITE   "${Esc}[1;37m")

macro(LOG_INFO log_str)
    message(STATUS "${BoldGreen}${log_str}${EndColor}")
endmacro()

macro(LOG_WARN log_str)
    message(STATUS "${BoldYellow}${log_str}${EndColor}")
endmacro()

macro(LOG_DEBUG log_str)
    message(STATUS "${BoldCyan}${log_str}${EndColor}")
endmacro()

macro(LOG_ERR log_str)
    message(STATUS "${BoldRed}${log_str}${EndColor}")
endmacro()
############################################################