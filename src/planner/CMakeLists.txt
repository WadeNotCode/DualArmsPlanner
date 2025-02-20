cmake_minimum_required(VERSION 3.0.2)
project(planner)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  moveit_ros_planning_interface
  roscpp
  std_msgs
  message_generation
)

add_message_files(
  FILES
  JointTrajectory.msg
  PoseJ.msg
  TraPairs.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

add_executable(moveit_trajectory_planner src/moveit_trajectory_planner.cpp)
target_link_libraries(moveit_trajectory_planner ${catkin_LIBRARIES})
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES planner
   CATKIN_DEPENDS message_runtime 
#  CATKIN_DEPENDS geometry_msgs moveit_ros_planning_interface roscpp
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(

  ${catkin_INCLUDE_DIRS}
)

