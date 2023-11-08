#!/bin/bash

G=$(tput setaf 2)
B=$(tput setaf 4)
C=$(tput setaf 6)
Y=$(tput setaf 3)
Q=$(tput sgr0)

all_images="all_images"

echo "${C}start: 解压镜像包${Q}"
if [ -f "$all_images.tar.gz" ]; then
  tar -xzvf "$all_images.tar.gz"
fi

for load_image in $(ls -l "$all_images" | awk '{print $9}'); do
  echo "${Y}    开始加载 $load_image 了...${Q}"
  docker load -i "./$all_images/$load_image"
done
