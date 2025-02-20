#include <fstream>
#include<stdio.h>
#include<cstring>
#include<sys/fcntl.h>
#include<sys/socket.h>
#include<unistd.h>
#include<netinet/in.h>
#include<errno.h>
#include<sys/types.h>
#include <arpa/inet.h>
#include "../include/search.hpp"
#include "../include/moveit_planner.hpp"
#include "../include/trajectory_generator.hpp"
#include <ros/callback_queue.h>
#include <thread>
#include <mutex>
#include <ros/ros.h>
#include <std_srvs/Empty.h>
#include <moveit/robot_model_loader/robot_model_loader.h>
#include <moveit/robot_state/robot_state.h>
#include <moveit/robot_state/conversions.h>
#include <moveit/robot_model/robot_model.h>
#include <moveit_msgs/GetStateValidity.h>
#include <fstream>

#define _PI_ 3.1416

void controlArms(Trajectory_Planner &planner1, Trajectory_Planner &planner2, std::vector<RobotCT::PosePair<RobotCT::PoseV>> &pose_array, bool is_execute)
{
    int start_index = 0;
    std::vector<planner::PoseJ> joints_pose_lines;
    // IK求解失败点
    std::vector<int> IK_failure;
    // 规划失败点
    std::vector<int> plan_failure;
    RobotCT::PoseJ pose_start_1(0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    RobotCT::PoseJ pose_start_2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    std::vector<std::vector<RobotCT::PoseJ>> points1;
    std::vector<std::vector<RobotCT::PoseJ>> points2;

    //此处更改信号源location各参数
    double generator_len = 0.25;
    double generator_width = 0.1;
    std::vector<double> trans_matrix_1 = {1,0,0,1,0,1,0,-0.75,0,0,1,-0.3,0,0,0,1};
    std::vector<double> trans_matrix_2 = {-1,0,0,0.9,0,-1,0,-0.75,0,0,1,-0.05,0,0,0,1};
    for(int i = 0;i < pose_array.size();i++)
    {
        // IK求解，求解失败直接舍弃 pair
        IK ik_1(pose_array[i].pose1,trans_matrix_1);
        IK ik_2(pose_array[i].pose2,trans_matrix_2);
        std::vector<RobotCT::PoseJ> valid_solutions1 = {};
        std::vector<RobotCT::PoseJ> valid_solutions2 = {};
        bool success;
        if((ik_1.IK_solve(valid_solutions1)&&ik_2.IK_solve(valid_solutions2))!=1)
        {
            IK_failure.push_back(i);
            continue;
        }
        else
        {
            points1.push_back(valid_solutions1);
            points2.push_back(valid_solutions2);
        }
    }
    std::cout << "Numbers of success IK1: " << points1.size() << std::endl;
    std::cout << "Numbers of success IK2: " << points2.size() << std::endl;
    std::vector<RobotCT::trajectory_pair<planner::PoseJ>> trajectory;

    // 打开文件以记录关节值
    std::ofstream planner1_log("planner1_joint_values.log");
    std::ofstream planner2_log("planner2_joint_values.log");
    if (!planner1_log.is_open() || !planner2_log.is_open()) {
        std::cerr << "Failed to open log files!" << std::endl;
        return;
    }

    for(int i = 0;i < points1.size() - 1;i++)
    {
        int k1,k2;
        k1 = joints_choose(pose_start_1,points1[i],points1[i+1],0);
        k2 = joints_choose(pose_start_2,points2[i],points2[i+1],0);
        std::vector<float> p1(6, 0.0);
        std::vector<float> p2(6, 0.0);
        for (int n = 0; n<6;n++)
        {
            p1[n] = points1[i][k1].joints[n];
            p2[n] = points2[i][k2].joints[n];
        }

        //探测器先行规划，若探测器规划失败则舍弃
        bool arm1_success = planner1.joints_plan(p1, is_execute);
        if (arm1_success)
        {
            bool arm2_success = planner2.joints_plan(p2, is_execute);
            if (arm2_success)
            {
                RobotCT::trajectory_pair<planner::PoseJ> trajectory_pair_(start_index, i + 1);
                start_index = i + 1;
                for (int j=0; j<joints_pose_lines.size(); j++) 
                {
                    trajectory_pair_.joints_pose_array_1.push_back(joints_pose_lines[j]);
                    if(joints_pose_lines.size()>0)
                    {
                        // 记录 planner1 的关节值
                        for (int k = 0; k < 6; ++k) 
                        {
                            planner1_log << planner1.joints_pose_array[j].joints[k];
                            if (k < 5) {
                                planner1_log << ", ";
                            }
                        }
                        planner1_log << std::endl;
                    }
                }
                for (int j=0; j<planner1.joints_pose_array.size() - 1; j++) 
                {
                    trajectory_pair_.joints_pose_array_1.push_back(planner1.joints_pose_array[j]);
                    // 记录 planner1 的关节值
                    for (int k = 0; k < 6; ++k) 
                    {
                        planner1_log << planner1.joints_pose_array[j].joints[k];
                        if (k < 5) {
                            planner1_log << ", ";
                        }
                    }
                    planner1_log << std::endl;
                }
                for (int j=0; j<planner2.joints_pose_array.size() - 1; j++) 
                {
                    trajectory_pair_.joints_pose_array_2.push_back(planner2.joints_pose_array[j]);
                    // 记录 planner2 的关节值
                    for (int k = 0; k < 6; ++k) 
                    {
                        planner2_log << planner2.joints_pose_array[j].joints[k];
                        if (k < 5) {
                            planner2_log << ", ";
                        }
                    }
                    planner2_log << std::endl;
                }
                trajectory.push_back(trajectory_pair_);
                joints_pose_lines.clear();
            }
            else
            {
                //保存探测器已执行的轨迹点
                for (int j=0; j<planner1.joints_pose_array.size() - 1; j++) 
                {
                    joints_pose_lines.push_back(planner1.joints_pose_array[j]);
                }
                plan_failure.push_back(i);
            }
        }
    }
    planner1_log.close();
    planner2_log.close();
    
}



int main(int argc, char **argv)
{
    //ROS初始化
    ros::init(argc, argv, "wtkd_planner");
    ros::NodeHandle node_handle;
    ros::AsyncSpinner spinner(1);
    spinner.start();
    moveit::planning_interface::PlanningSceneInterface planning_scene_interface;
    ros::Rate r(1);

    //创建规划器类
    Trajectory_Planner planner1(node_handle, "arm1");
    Trajectory_Planner planner2(node_handle, "arm2");

    bool is_execute = true; 

    //创建轨迹规划点
    float center[3] = {0.0, 0.0, 0.9};
    float direction[3] = {0.8, 0.6, 0.0};
    Generator::Circle circle_1 = Generator::Circle(center, 0.5, direction, 0.0174, 1.87, 2.84);
    Generator::Circle circle_2 = Generator::Circle(center, 0.5, direction, 0.0174, -1.27, -0.3);
    std::vector<RobotCT::PosePair<RobotCT::PoseV>> pose_array;
    for(int i=0;i<circle_1.circle_posev.size();i++)
    {
        RobotCT::PosePair<RobotCT::PoseV> pair_posev(circle_1.circle_posev[i], circle_2.circle_posev[i]);
        // 机械臂1和机械臂2的轨迹点对
        pose_array.push_back(pair_posev); 
    }           

    // 启动机械臂轨迹规划线程
    controlArms(planner1, planner2, pose_array, is_execute);
    ros::waitForShutdown();
    spinner.stop();
    return 0;
}
