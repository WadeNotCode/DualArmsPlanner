#ifndef PLANNER_HPP
#define PLANNER_HPP

#include <geometry_msgs/Pose.h>
#include <ros/ros.h>
#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>
#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>
#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>
#include <moveit_visual_tools/moveit_visual_tools.h>
#include <moveit_msgs/RobotTrajectory.h>
#include <trajectory_msgs/JointTrajectoryPoint.h>
#include <thread>
#include <mutex>
#include <fstream>
#include <vector>
#include "trajectory.hpp"
#include "planner/PoseJ.h"
#include <visualization_msgs/Marker.h>
using namespace RobotCT;
class Trajectory_Planner
{

private:
    ros::NodeHandle& node_handle_;
    moveit::planning_interface::MoveGroupInterface move_group;
    moveit::planning_interface::PlanningSceneInterface planning_scene_interface;
    moveit::planning_interface::MoveGroupInterface::Plan plan;
    geometry_msgs::Pose current_pose;
    geometry_msgs::Pose goal_pose;
    std::string arm_name;

public:
    std::vector<planner::PoseJ> joints_pose_array;
    Trajectory_Planner(ros::NodeHandle& nh, const std::string & name) : 
    node_handle_(nh), 
    move_group(name)
    {
        arm_name = name;
        moveit::planning_interface::PlanningSceneInterface planning_scene_interface;
        moveit::planning_interface::MoveGroupInterface::Plan plan;
        move_group.setPoseReferenceFrame("base_ground");
        current_pose = move_group.getCurrentPose().pose;
        std::cout << "Group name: " << name << std::endl;
        std::cout << "Current Position: x=" << current_pose.position.x
                << ", y=" << current_pose.position.y
                << ", z=" << current_pose.position.z << std::endl;
        std::cout << "Current Orientation: x=" << current_pose.orientation.x
                << ", y=" << current_pose.orientation.y
                << ", z=" << current_pose.orientation.z
                << ", w=" << current_pose.orientation.w << std::endl;
        sleep(1.0);
    }

    void PoseV_convert_pose(const PoseV & posev)
    {
        goal_pose.position.x = posev.position.x();
        goal_pose.position.y = posev.position.y();
        goal_pose.position.z = posev.position.z();
        goal_pose.orientation.x = posev.orientation.x();
        goal_pose.orientation.y = posev.orientation.y();
        goal_pose.orientation.z = posev.orientation.z();
        goal_pose.orientation.w = posev.orientation.w();
    }

    void trajectory_convert()
    {
        joints_pose_array.clear();
        if (joints_pose_array.empty())
        {
            for (size_t i = 0; i < plan.trajectory_.joint_trajectory.points.size(); ++i) 
            {
                planner::PoseJ posej;
                trajectory_msgs::JointTrajectoryPoint& point = plan.trajectory_.joint_trajectory.points[i];
                for (size_t i = 0; i < point.positions.size() && i < 6; ++i)
                    posej.joints[i] = point.positions[i];
                joints_pose_array.push_back(posej);

            }
        }
        else
        {
            std::cout << "List is not empty." <<std::endl;
        }
    }

    bool is_current_pose(const PoseV & posev)
    {
        current_pose = move_group.getCurrentPose().pose;
        PoseV_convert_pose(posev);
        float error_accumulated = 0;
        error_accumulated += std::abs(goal_pose.position.x  - current_pose.position.x);
        error_accumulated += std::abs(goal_pose.position.y  - current_pose.position.y);
        error_accumulated += std::abs(goal_pose.position.z  - current_pose.position.z);
        error_accumulated += std::abs(goal_pose.orientation.x - current_pose.orientation.x);
        error_accumulated += std::abs(goal_pose.orientation.y - current_pose.orientation.y);
        error_accumulated += std::abs(goal_pose.orientation.z - current_pose.orientation.z);
        // If x,y,z is same, then w will be the same value.
        if(error_accumulated < 0.0001)
        {
            return true;
        }
        else
            return false;
    }

    bool waypoints_plan(const PoseV & posev,bool is_execute, int index1, int index2)
    {
        if(is_current_pose(posev))
        {
            std::cout << "Target pose is already nearby the current pose." << std::endl;
            return false;
        }
        PoseV_convert_pose(posev);
        move_group.setPoseTarget(goal_pose);
        // 规划轨迹
        bool success = (move_group.plan(plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
        if(success)
        {
            trajectory_convert();
            // 执行轨迹
            if(is_execute)
                move_group.execute(plan);
                move_group.clearPoseTargets();
            return true;
        }
        else
        {
            std::cout << arm_name << "Wayponits " << index1 << " to " << index2 << " planning failed." << std::endl;
            return false;
        }
    }

    
    bool joints_plan(const std::vector<float>& joint_values ,bool is_execute)
    {
        std::vector<double> double_vector;
        double_vector.resize(joint_values.size());
        std::transform(joint_values.begin(), joint_values.end(), double_vector.begin(),
            [](float value) { return static_cast<double>(value); });
        move_group.setJointValueTarget(double_vector);
        move_group.setPlannerId("RRT");
        // 规划轨迹
        bool success = (move_group.plan(plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
        if(success)
        {   
            // 执行轨迹
            if(is_execute == true)
            {
                if (move_group.execute(plan))
                {
                    trajectory_convert();
                    return true;
                }
                else
                    return false;
            }
        }
        else
        {
            std::cout << "Joints planning failed." << std::endl;
            return false;
        }
    }


    //Detect the maximum joint distance in a trajectory.
    float distance(const std::vector<PoseJ> & joints_pose_array)
    {
        float delta_ = 0;
        float delta = 0;
        for (int j=0; j<joints_pose_array.size() - 1; j++) 
        {
            delta_ = delta;
            delta = 0;
            for(int i=0; i<6; i++)
            {
                delta = delta + std::abs(joints_pose_array[j].joints[i] - joints_pose_array[j+1].joints[i]);
            }
            if (delta_ > delta)
                delta = delta_;
        }
        return delta;
    }

};

#endif 