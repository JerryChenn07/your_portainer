#!/bin/bash

G=$(tput setaf 2)
B=$(tput setaf 4)
C=$(tput setaf 6)
Y=$(tput setaf 3)
Q=$(tput sgr0)

all_images="all_images"
# 创建文件夹，不管是否存在
mkdir -p $all_images

for image_name in $(cat "./$all_images.txt"); do
  echo "${Y}    准备保存 $image_name 了...${Q}"
  save_image_name=$(echo $image_name | awk -F'/' '{print $NF}' | sed 's/:/_/g')
  echo "${Y}    开始保存 $save_image_name 了...${Q}"
  docker save "$image_name" | gzip > "./$all_images/$save_image_name.tar.gz"
done

# 确认你的存储空间足够
tar zcvf $all_images.tar.gz $all_images