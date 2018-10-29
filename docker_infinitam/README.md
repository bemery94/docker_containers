This docker container installs ubuntu14, cuda 7 and ros indigo. The Makefile allows for easy compilation and running of the container.

# Installation
* Make sure that you have nvidia-docker installed and NOT nvidia-docker2. Nvidia-docker2 has issues with using the GUI/x-server within the docker container.j

# Make Commands
Build: 
* `make pull` (This will pull the image from the web which is much faster than building from scratch)
* `make build` (After pulling the image, you can make local changes to the Dockerfile and rebuild. Note. it generally is still faster to pull before running `make build`.
Create an instance of a container: `make run`

# Build ROS pkgs
* Run the infinitam_install_script.sh

