This docker container installs ubuntu14, cuda 8 and ros indigo. The Makefile allows for easy compilation of the container and then allows a roscore and any number of instances of the container to be run by passing in a different argument for $NAME. These instances are all connects with the roscore and you can connect to the roscore from your local computer as outlined below.

# Connect to roscore running in Docker container on local computer
- Set the ROS_IP and ROS_MASTER_URI in the roscore docker image Dockerfile
- Set the same ROS_MASTER_URI in the other machines.
- On each other machine, run $ hostname -I and get the IP address on the same network as ROS_MASTER_URI and then set ROS_IP to that IP address.

# Run Commands
Build: `make build`
Create an instance of a container: `make run NAME=my_node_name`
Create a roscore: `make roscore`
