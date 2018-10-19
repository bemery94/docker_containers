FROM nvidia/cuda:8.0-devel-ubuntu14.04
MAINTAINER Brendan Emery <b.emery94@gmail.com>

################## Install dependencies ##################
# install packages
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    cmake \
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
    build-essential \
    g++ \
    gcc \    
    gdb \
    git \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libavformat-dev \
    libpq-dev \
    pkg-config \
    ros-indigo-ros-core=1.1.6-0* \
    unzip \
    wget \
    vim \
    yasm \
    && rm -rf /var/lib/apt/lists/*

# Install OpenCV2
# GUI (if you want to use GTK instead of Qt, replace 'qt5-default' with 'libgtkglext1-dev' and remove '-DWITH_QT=ON' option in CMake):

RUN wget https://github.com/opencv/opencv/archive/2.4.13.3.zip \
&& unzip 2.4.13.3.zip \
&& mkdir /opencv-2.4.13.3/cmake_binary \
&& cd /opencv-2.4.13.3/cmake_binary \
&& cmake -DWITH_QT=OFF \
        -DWITH_OPENGL=ON \
        -DFORCE_VTK=OFF \
        -DWITH_TBB=ON \
        -DWITH_GDAL=ON \
        -DCUDA_ARCH_PTX=OFF \
        -DCUDA_ARCH_BIN=61 \
        -DWITH_XINE=ON \
        -DBUILD_EXAMPLES=OFF \
        -DENABLE_PRECOMPILED_HEADERS=OFF .. \
&& make install -j7 \
&& rm /2.4.13.3.zip \
&& rm -r /opencv-2.4.13.3

# Add ROS pkgs
RUN apt-get update && apt-get install -y \
    ros-indigo-cv-bridge \
    ros-indigo-eigen-conversions \
    ros-indigo-image-transport \
    ros-indigo-pcl-msgs \
    ros-indigo-pcl-conversions \
    ros-indigo-tf \
    ros-indigo-tf-conversions \
    && rm -rf /var/lib/apt/lists/*

# Forgotten pkgs
#RUN apt-get update && apt-get install -y \
#    && rm -rf /var/lib/apt/lists/*


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
RUN mkdir -p /home/brendan/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/indigo/setup.bash; catkin_init_workspace /home/brendan/catkin_ws/src'
RUN /bin/bash -c '. /opt/ros/indigo/setup.bash; cd /home/brendan/catkin_ws; catkin_make'
RUN echo "source ~/catkin_ws/devel/setup.bash" >> /home/brendan/.bashrc

# Check if the git repo has been updated, and if so, reset the docker cache so it repulls.
#ADD https://api.github.com/repos/bemery94/ros_kinfu/git/refs/heads/master version.json
#RUN /bin/bash -c '. /opt/ros/indigo/setup.bash; cd /home/brendan/catkin_ws/src; git clone https://github.com/bemery94/ros_kinfu.git; cd ..;  catkin_make '
RUN ln -s /home/brendan/work/iit/teleop_force_fields/ros_kinfu /home/brendan/catkin_ws/src/
RUN chown ${NB_USER1}:${NB_GID} -R /home/brendan/catkin_ws

USER ${NB_USER1}

EXPOSE 8888
