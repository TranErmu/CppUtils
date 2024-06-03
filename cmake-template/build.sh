#!/bin/bash

help_info="
Usage:
\n\tbuild.sh [options] [parameters]
\nOptions:
\n\t-t, --type <platform>       build for <platform>\n
\n\t-h, --help                  print help infomation\n
"

null_info="
miss argument
\nTry '$0 --help' for more information.
"

invalid_info="
invalid argument
\nTry '$0 --help' for more information.
"

CROSS_PREFIX=
BUILD_PATH=$(pwd)/build

function info()
{
    while true
    do
        case "$1" in 
            "null")
                echo -e ${null_info}
                break
                ;;
            "help")
                echo -e ${help_info}
                break
                ;;
            "invalid")
                echo -e ${invalid_info}
                break
                ;;
        esac
    done
}

function mk_build_dir()
{
    if [ ! -d "${BUILD_PATH}" ]; then
        mkdir ${BUILD_PATH}
    fi
    cd ${BUILD_PATH}
}

function make_arm()
{
    echo "-- Build for arm"
    CROSS_PREFIX="arm-linux-gnueabihf-"
    distclean
    mk_build_dir
    cmake -DCMAKE_C_COMPILER=${CROSS_PREFIX}gcc -DCMAKE_CXX_COMPILER=${CROSS_PREFIX}g++ -DCMAKE_BUILD_TYPE=Debug ..
    make install
}

function make_x86_64()
{
    echo "-- Build for x86_64"
    CROSS_PREFIX=""
    distclean
    mk_build_dir
    cmake .. -DCMAKE_C_COMPILER=${CROSS_PREFIX}gcc -DCMAKE_CXX_COMPILER=${CROSS_PREFIX}g++ -DCMAKE_BUILD_TYPE=Debug
    make install
}

function distclean()
{
    echo "-- Clean Build Cache"
    if [ ! -d ${BUILD_PATH} ]; then
        return
    fi
    cd ${BUILD_PATH}
    rm -rf *
    rm -rf .cmake*
}


## main
ARGS=$(getopt -o t:hc -l type:,help,clean -n $0 -- "$@")
if [ $? != 0 ]; then
    exit -1
fi

eval set -- "${ARGS}"

if [[ $# == 0 ]] || [[ $1 == "--" ]]; then
    make_x86_64
    exit 0
fi

while true
do
    case "$1" in
        -t|--type) 
            case $2 in
                arm*)
                    make_arm
                    ;;
                x86_64*)
                    make_x86_64
                    ;;
                *)
                    info invalid
                    ;;
            esac
            shift 2 # 有两个参数，使用完去掉 -t arm
            ;;
        -h|--help)
            info help;
            shift 1
            ;;
        -c|--clean)
            distclean
            shift 1
            ;;
        --)
            shift
            break
            ;;
        *)
            shift 1
            exit 1
            ;;
    esac
done

