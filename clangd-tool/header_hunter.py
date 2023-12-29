#!/usr/bin/python3
import os
import glob
import sys

def find_unique_header_paths(folder_path):
    folder_path=os.path.abspath(folder_path)
    header_paths = set()

    # 遍历当前目录及子目录中的.h文件
    for file_path in glob.glob(os.path.join(folder_path, '**', '*.h'), recursive=True):
        if not os.path.dirname(file_path) in header_paths:
            print(f"Add *.h header path {os.path.dirname(file_path)}")
            header_paths.add(os.path.dirname(file_path))

     # 遍历当前目录及子目录中的.hpp文件
    for file_path in glob.glob(os.path.join(folder_path, '**', '*.hpp'), recursive=True):
        if not os.path.dirname(file_path) in header_paths:
            print(f"Add *.hpp header path {os.path.dirname(file_path)}")
            header_paths.add(os.path.dirname(file_path))

    split_paths = []
    split_paths.append(folder_path)

    for path in header_paths:
        # 确保路径以folder_path开头，否则跳过
        if not path.startswith(folder_path):
            continue
        
        # 拆解路径并添加到列表，保留最短的路径部分
        parts = []
        while path != folder_path:
            path, tail = os.path.split(path)
            if tail:
                parts.append(os.path.join(path, tail))
            else:
                parts.append(path)
                break

        split_paths.extend(parts)

    return sorted(set(split_paths))

def write_compile_flags_file(output_file, header_paths):
    lines = [
        'If:',
        '    PathMatch: [.*/.cpp, .*/.cxx, .*/.cc, .*/.h, .*/.hpp, .*/.hxx]',
        'CompileFlags:',
        '    Compiler: g++',
        '    Add:',
        '        - \"-std=c++11\"',
        '---',
        'If:',
        '   PathMatch: [.*/.c]',
        'CompileFlags:',
        '    Compiler: gcc',
        '    Add:',
        '        - \"-std=c99\"',
        '---'
    ]

    compile_flags = ["CompileFlags:", "    Add:"]

    for header_path in header_paths:
        # print(f"Add header path {header_path}")
        compile_flags.append(f"        - -I{header_path}")

    with open(output_file, 'w') as file:
        file.write('\n'.join(lines + compile_flags))


def main():
    # 获取当前文件夹路径
    current_folder = os.getcwd()

    # 获取唯一的.h和.hpp文件所在路径集合
    unique_header_paths = []

    directories = sys.argv[1:]
    directories.append(current_folder)

    for directory in directories:
        print(f"-- Searching for header files in: {directory}")
        unique_header_paths += find_unique_header_paths(directory)

    write_compile_flags_file(".clangd", unique_header_paths)

if __name__ == "__main__":
    main()