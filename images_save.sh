#!/bin/bash

# 入口函数
main() {
  # 定义路径变量
  project_path="./"
  yml_path="$project_path"
  
  # 执行函数
  pull_images "$project_path$yml_path"
  package_images "$project_path"
}

# 获取当前路径下所有文件
get_files() {
    path=$1
    files_list=""
    for file in "$path"*; do
        if [ -f "$file" ]; then
            files_list+=" $file"
        fi
    done
    echo '%s' "$files_list"
}

# 拉取images
pull_images() {
  path=$1
  files=$(get_files $path)
  contents=""
  
  # 遍历文件，获取 image 名称
  for file in $files; do
    if [[ "$file" != *".yml"* ]]; then
      continue
    fi
    
    while IFS='' read -r line || [[ -n "$line" ]]; do
      if [[ "$line" == "image: "* ]]; then
        contents+="${line#image: }\n"
      fi
    done < "$file"
  
    echo 'From file: %s get images\n%s\n' "$file" "$contents"
  done
  
  # 将获取到的 image 名称写入文件
  echo '%s' "$contents" > "$path/images.txt"
  echo 'Write images to images.txt\n'
  
  # 拉取 images
  echo 'Start pulling images in 10 seconds...\n'
  sleep 10
  
  while IFS= read -r image_name; do
    command="docker pull $image_name"
    echo '%s\n' "$command"
    response=$($command)
    echo '%s\n' "$response"
  done < "$path/images.txt"
}

# 打包images
package_images() {
  # 创建images文件夹，不用管是否存在
  mkdir -p "images"
  path="$1"
  
  while IFS='' read -r image_name || [[ -n "$image_name" ]]; do
    image_save_name=$(echo "$image_name" | awk -F'/' '{print $NF}' | sed 's/:/_/g')
    command="docker save $image_name | gzip > ./images/$image_save_name.tar.gz"
    echo '%s\n' "$command"
    response=$($command)
    echo '%s\n' "$response"
  done < "$path/images.txt"
}

# 调用入口函数
main