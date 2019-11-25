#!/usr/bin/bash

#docker-machine ssh default<< build-sh
##########
# config
##########
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh
source ${basepath}/lang.sh


##########
# main
##########
now_step=step_00
echo "# $now_step -> ${lang_steps[$now_step]}"
docker build --tag ${hub_address}${hub_ns}${hub_tag} ${my_dockerfile_path}
# docker-machine ssh $my_vm_name "docker build --tag ${hub_address}${hub_ns}${hub_tag} ${my_dockerfile_path}"

now_step=step_01
echo "# $now_step -> ${lang_steps[$now_step]}"
#docker images
#docker-machine ssh $my_vm_name "docker images"
image_id=$(docker images --filter=reference="${hub_address}${hub_ns}${hub_tag}" --format "{{.ID}}")
echo "$my image id is ${image_id}"

now_step=step_02
echo "# $now_step -> ${lang_steps[$now_step]}"
#docker run -d ${image_id} docker ps
docker run --rm ${hub_address}${hub_ns}${hub_tag} ls -al /
#docker-machine ssh $my_vm_name "docker run --rm ${hub_address}${hub_ns}${hub_tag} ls -al /"


now_step=step_03
echo "# $now_step -> ${lang_steps[$now_step]}"
docker login -u ${user_u} -p ${user_p} ${hub_address}
#docker-machine ssh $my_vm_name "docker login -u ${user_u} -p ${user_p} ${hub_address}"

now_step=step_04
echo "# $now_step -> ${lang_steps[$now_step]}"
docker tag  ${image_id} ${hub_address}${hub_ns}${hub_tag}
#docker-machine ssh $my_vm_name "docker tag ${image_id} ${hub_address}${hub_ns}${hub_tag}"

now_step=step_05
echo "# $now_step -> ${lang_steps[$now_step]}"
docker push ${hub_address}${hub_ns}${hub_tag}
#docker-machine ssh $my_vm_name "docker push ${hub_address}${hub_ns}${hub_tag}"

