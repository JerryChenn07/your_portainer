import os
import time
import sys

# 兼容 Python2
if sys.version_info[0] == 3:
    import subprocess
else:
    import commands as subprocess


def get_files(path):
    """获取当前路径下所有文件"""
    files_list = []
    for filename in os.listdir(path):
        # 检查是否为文件
        if os.path.isfile(os.path.join(path, filename)):
            files_list.append(filename)

    return files_list


def pull_images(path):
    contents = ''
    files_list = get_files(path)
    for file in files_list:
        if 'yml' not in file:
            continue
        with open(path + file, 'r') as f:
            f_readlines = f.readlines()
        for line in f_readlines:
            if not line.strip().startswith('image: '):
                continue
            image_name = line.replace('image:', '').strip()
            contents += image_name + '\n'
        print('from file: {} get images'.format(file))
        print(contents)

    contents = contents.strip()
    with open(path + 'images.txt', 'w') as f:
        f.write(contents)
    print('write images to images.txt')

    print('10s后开始拉取images')
    time.sleep(10)
    # 遍历contents，拉取images
    for line in contents.split('\n'):
        image_name = line.strip()
        command = 'docker pull {}'.format(image_name)
        print(command)
        response = subprocess.getoutput(command)
        print(response)


def package_images(path):
    # 创建images文件夹，不用管是否存在
    os.makedirs("images")
    with open(path + 'images.txt', 'r') as f:
        f_readlines = f.readlines()
    for line in f_readlines:
        image_name = line.strip()
        if not image_name:
            continue
        image_save_name = image_name.split(r'/')[-1].replace(r':', '_')
        command = 'docker save {} | gzip > ./images/{}.tar.gz'.format(image_name, image_save_name)
        print(command)
        response = subprocess.getoutput(command)
        print(response)


def main(project_path, yml_path):
    pull_images(project_path + yml_path)
    package_images(project_path)



if __name__ == '__main__':
    project_path = './'
    yml_path = project_path + ''
    main(project_path, yml_path)
