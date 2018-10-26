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
CATKIN_WS="/home/brendan/docker_containers/docker_infinitam/catkin_ws/"
WORK="/home/brendan/work/"
DOTFILES="/home/brendan/.bashrc"
USER_NAME=brendan
##################################################################

DOCKER=nvidia-docker
NAME?=this

pull:
	docker pull bemery94/infinitam

build: 
	docker build -t bemery94/infinitam \
		--build-arg python_version=2.7 \
		--build-arg NB_USER1=${NB_USER1} \
		--build-arg NB_UID1=${NB_UID1} \
		--build-arg NB_GROUP=${NB_GROUP} \
		--build-arg NB_GID=${NB_GID} \
		-f Dockerfile .

run: 
	$(DOCKER) run -it --rm --user ${USER_NAME}:${NB_GROUP} -e GRANT_SUDO=yes \
	     -v ${WORK}:${WORK} \
		 -v ${BASHRC}:${BASHRC} \
		 -v ${CATKIN_WS}:/home/brendan/catkin_ws \
		 --net=host \
		bemery94/infinitam bash

