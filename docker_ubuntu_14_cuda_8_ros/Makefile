help:
		@cat Makefile


##################################################################
# This is the jupyter/datascience notebook with some extra goodies
# added.
#
# Based on jupyter/datascience-notebook
####################### Build arguments###########################
NB_USER1=brendan
NB_UID1=1000
NB_GROUP=brendan
NB_GID=1000


####################### Run arguments ############################
CATKIN_WS="/home/brendan/catkin_ws/"
PACKAGES="/home/brendan/packages/"
WORK="/home/brendan/work/"
DOTFILES="/home/brendan/.bashrc"
USER_NAME=brendan
MASTER_IP=172.18.0.22
##################################################################

DOCKER=nvidia-docker
NAME?=this


build: 
	docker build -t bemery94/ubuntu_14_cuda_8_ros \
		--build-arg python_version=2.7 \
		--build-arg NB_USER1=${NB_USER1} \
		--build-arg NB_UID1=${NB_UID1} \
		--build-arg NB_GROUP=${NB_GROUP} \
		--build-arg NB_GID=${NB_GID} \
		-f Dockerfile .

roscore:
	docker network rm catkin_network 
	docker network create --subnet=172.18.0.0/16 catkin_network
	docker run -it --rm \
		--net catkin_network \
		--ip ${MASTER_IP} \
		--env ROS_IP=${MASTER_IP} \
		--env ROS_MASTER_URI=http://${MASTER_IP}:11311 \
		--name master \
		bemery94/roscore \
		roscore

run: 
	$(DOCKER) run -it --rm --user ${USER_NAME}:${NB_GROUP} -e GRANT_SUDO=yes \
	     -v ${WORK}:${WORK} -v ${PACKAGES}:${PACKAGES} \
		 -v ${BASHRC}:${BASHRC} \
		 --net catkin_network \
		 --name ${NAME} \
		 --env ROS_HOSTNAME=${NAME} \
		 --env ROS_MASTER_URI=http://${MASTER_IP}:11311 \
		bemery94/ubuntu_14_cuda_8_ros bash

