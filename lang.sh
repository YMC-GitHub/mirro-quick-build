#!/usr/bin/bash
# 定义关联数组
# 用于设语言包
declare -A lang_steps
lang_steps=(
    [step_00]="构建本地镜像" 
    [step_01]="列出本地镜像" 
    [step_02]="验证构建镜像" 
    [step_03]="登录镜像仓库"
    [step_04]="本地镜像打标"
    [step_05]="推送本地镜像"
)

:<<EOF
# 遍历关联数组
test_lang_steps(){
for key in ${!lang_steps[*]}
do
    echo "$key -> ${lang_steps[$key]}"
done
}
 test_lang_steps $lang_steps $step_key
EOF