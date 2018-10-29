FROM nvidia/cuda:7.0-devel-ubuntu14.04
MAINTAINER Brendan Emery <b.emery94@gmail.com>

################## Install dependencies ##################
# install packages
RUN apt-get update && apt-get install -q -y \
    autoconf \
    dirmngr \
    gnupg2 \
    libtool \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
ENV ROS_DISTRO indigo
RUN apt-get update && apt-get install -y \
    ros-indigo-ros-core=1.1.6-0* \
    build-essential \
    g++ \
    gcc \    
    gdb \
    git \
    libeigen3-dev \
    ros-indigo-actionlib \
    ros-indigo-cv-bridge \
    ros-indigo-dynamic-reconfigure \
    ros-indigo-geometry2 \
    ros-indigo-nodelet \
    ros-indigo-nodelet-topic-tools \
    ros-indigo-orocos-kdl \
    ros-indigo-pcl-msgs \
    ros-indigo-pcl-conversions \
    ros-indigo-perception-pcl \
    ros-indigo-tf \
    ros-indigo-tf2-bullet \
    software-properties-common \
    unzip \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Setup new workspace
ARG NB_USER1=brendan
ARG NB_UID1=1000

ARG NB_GROUP=brendan
ARG NB_GID=1000

RUN groupadd -r ${NB_GROUP} -g ${NB_GID} && \
    useradd -m -s /bin/bash -N -u ${NB_UID1} ${NB_USER1} -g ${NB_GROUP} && \
    mkdir -p /home/${NB_USER1}/ && \
    chown ${NB_USER1} /home/${NB_USER1}/ \
    && echo "$NB_USER1:$NB_USER1" | chpasswd \
    && adduser $NB_USER1 sudo

WORKDIR /home/brendan

COPY ./dotfiles /home/brendan/dotfiles
RUN /home/brendan/dotfiles/make_sym_links.sh

# Python
ARG python_version=2.7

# Create a ROS workspace for the ROS user.
RUN echo "source ~/catkin_ws/devel/setup.bash" >> /home/brendan/.bashrc

USER ${NB_USER1}

EXPOSE 8888
