#!/bin/bash
{
	gnome-terminal -- bash -c "roscore; echo 'Roscore started';exec bash"
}&

sleep 3
{
	gnome-terminal -- bash -c "source ./devel/setup.bash; 
                          roslaunch moveit_config demo.launch;
                          exec bash"
}&
sleep 3
{
	gnome-terminal -- bash -c "source ./devel/setup.bash;
						  rosrun planner moveit_trajectory_planner;
						  exec bash"
}

