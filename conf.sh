#!/usr/bin/bash

######
### 发布
######
image_id=
# 镜像仓库用户账户
user_u=hualei03042013@163.com
# 镜像仓库用户密码
user_p=
# 镜像仓库地址
hub_address=hub.c.163.com
# 镜像仓库空间
hub_ns=yemiancheng
# 镜像标签
hub_tag=alpine-node

######
### 构建
######
# 虚拟机器名字
my_vm_name=default
# 镜像配置文件位置
my_dockerfile_path=/docker/bin/mirro-quick-build

######
### 提示
######
# 当前步骤
now_step=
# 下一步骤
go_to_next_step=
