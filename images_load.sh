#!/bin/bash

G=$(tput setaf 2)
B=$(tput setaf 4)
C=$(tput setaf 6)
Y=$(tput setaf 3)
Q=$(tput sgr0)

echo "${C}start: 解压镜像包${Q}"
if [ -f "images.tar.gz" ]; then
  tar -xzvf images.tar.gz
fi

for load_image in $(ls -l images | awk '{print $9}'); do
  echo "${Y}    开始加载$load_image...${Q}"
  docker load -i ./images/$load_image
done
