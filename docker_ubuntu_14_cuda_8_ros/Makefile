help:
		@cat Makefile


##################################################################
# This is the jupyter/datascience notebook with some extra goodies
# added.
#
# Based on jupyter/datascience-notebook
####################### Build arguments###########################
NB_USER1=brendan
NB_UID1=1001
NB_GROUP=brendan
NB_GID=1001


####################### Run arguments ############################
CATKIN_WS="/home/brendan/docker_containers/docker_ubuntu_14_cuda_8_ros/catkin_ws/"
PACKAGES="/home/brendan/packages/"
WORK="/home/brendan/work/"
DOTFILES="/home/brendan/.bashrc"
USER_NAME=brendan
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

run: 
	$(DOCKER) run -it --rm --user ${USER_NAME}:${NB_GROUP} -e GRANT_SUDO=yes \
	     -v ${WORK}:${WORK} -v ${PACKAGES}:${PACKAGES} \
		 -v ${BASHRC}:${BASHRC} \
		 -v ${CATKIN_WS}:/home/brendan/catkin_ws \
		 --net=host \
		 --privileged \
		bemery94/ubuntu_14_cuda_8_ros bash
