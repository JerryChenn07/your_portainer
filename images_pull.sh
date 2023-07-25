#!/bin/bash


# 拉取所有镜像:
cat *.yml | grep image | grep -v '#' | awk '{print$2}'| sort | uniq | xargs -n1 docker pull


# 保存所有镜像成tar包（需要私有化部署）:
# cat *.yml | grep image | grep -v '#' | awk '{print$2}' | sort | uniq | xargs docker save > idps_all_images.tar
