help:
		@cat Makefile


##################################################################
# This is the jupyter/datascience notebook with some extra goodies
# added.
#
# Based on jupyter/datascience-notebook
####################### Build arguments###########################
NB_USER1=emery
NB_USER2=mitesh
NB_UID1=27022
NB_UID2=27008
NB_GROUP=pal
NB_GID=10000


####################### Run arguments ############################
DATA="/home/emery/projects/data/"
SRC="/home/emery/projects/DeepLearningLocalization/"
USER_NAME=emery
GPU?=0
##################################################################

DOCKER=NV_GPU=$(GPU) nvidia-docker


build: 
	docker build -t bemery94/keras_gpu \
		--build-arg python_version=2.7 \
		--build-arg NB_USER1=${NB_USER1} \
		--build-arg NB_USER2=${NB_USER2} \
		--build-arg NB_UID1=${NB_UID1} \
		--build-arg NB_UID2=${NB_UID2} \
		--build-arg NB_GROUP=${NB_GROUP} \
		--build-arg NB_GID=${NB_GID} \
		-f Dockerfile .

run: 
	$(DOCKER) run -it --user ${USER_NAME}:${NB_GROUP} -e GRANT_SUDO=yes \
		-v $(SRC):$(SRC) -v $(DATA):$(DATA) \
		--env KERAS_BACKEND=tensorflow bemery94/keras_gpu bash
test: 
	$(DOCKER) run -it --user ${USER_NAME}:${NB_GROUP} -e GRANT_SUDO=yes \
		--net=host -v $(SRC):$(SRC) -v $(DATA):$(DATA) \
		--env KERAS_BACKEND=tensorflow bemery94/keras_gpu 

jupyter:
	$(DOCKER) run -it -p 8889:8889 -p 8888:8888 -p 6006:6006 --user ${USER_NAME}:${NB_GROUP} -e GRANT_SUDO=yes \
		-v $(SRC):$(SRC) -v $(DATA):$(DATA) \
		--net=host --env KERAS_BACKEND=tensorflow bemery94/keras_gpu bash
