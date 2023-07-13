#!/bin/bash

R=$(tput setaf 1) # 红色
G=$(tput setaf 2) # 绿色
B=$(tput setaf 4) # 蓝色
C=$(tput setaf 6) # 青色
Y=$(tput setaf 3) # 黄色
Q=$(tput sgr0)    # 重置

# 绝对路径
absolute_path=""
# 待打包的项目
projects_list=(
  'your_portainer'
  #  'deploy_ocr'
)

# 打包前确认一下
function confirmProject() {
  #遍历待打包项目
  echo "${R}遍历待打包项目:${Q}"
  for project in "${projects_list[@]}"; do
    # 进入项目目录
    echo "${R}进入项目目录:${Q} ${absolute_path}${project}"
    cd ${absolute_path}${project}

    # 查看git分支
    echo "${R}查看git分支:${Q}"
    git branch
  done

  # 确认要打包的分支
  read -p "${G}确认完要打包的分支了吗(Y/N,默认N)?:${Q}" is_confirm
  if [ -z "${is_confirm}" ]; then
    is_confirm="N"
  fi
  if [ "${is_confirm}" == "Y" ]; then
    cd ${absolute_path}
  fi
  echo "${R}确认完毕，准备开始打包${Q}"
}

# 打包前确认一下
function copyProject() {
  cd ${absolute_path}
  deploy_demos="deploy_demos"
  mkdir ${deploy_demos}

  echo "${R}开始复制项目${Q}"
  for project in "${projects_list[@]}"; do
    # 进入项目目录
    cp -r ${project} ${deploy_demos}
    rm -rf ${deploy_demos}/${project}/.git
  done
  echo "${R}复制项目完毕${Q}"

  tar zcvf ${deploy_demos}.mp4 ${deploy_demos}
  echo "${R}打包压缩完毕${Q}"
}

confirmProject
copyProject
