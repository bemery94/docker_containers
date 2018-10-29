#!/bin/bash
mv ~/catkin_ws/src/infinitam ~/catkin_ws 
cd ~/catkin_ws 
catkin_make -DCMAKE_BUILD_TYPE=Debug
mv ~/catkin_ws/infinitam ~/catkin_ws/src/infinitam
catkin_make -DCMAKE_BUILD_TYPE=Debug
