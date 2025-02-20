// -----------------------------------------------------------------------------
// Filename: trajectory.hpp
// Description: Define the data structure of scanning trajectory.
// 
// Author: Hou Qinhan
// Copyright © 2024-2024 Wantong Kangda Testing Technology. All Rights Reserved.
// -----------------------------------------------------------------------------

#ifndef TRAJECTORY_HPP
#define TRAJECTORY_HPP

#include <iostream>
#include <string>
#include <list>
#include <eigen3/Eigen/Core>
#include <eigen3/Eigen/Dense>
#include <eigen3/Eigen/Geometry>
#include "define.hpp"

#include <vector>

namespace RobotCT
{
    using namespace Eigen;
    class PoseV
    {
    public:
        Vector3f position;
        Quaternionf orientation;
    public:
        PoseV(Vector3f position, Quaternionf orientation)
            : position(position), orientation(orientation) {}
        PoseV(float vx, float vy, float vz, float qw, float qx, float qy, float qz)
            : position(Vector3f(vx, vy, vz)), orientation(Quaternionf(qw, qx, qy, qz)) {}
        std::string toString() const;
    };

    class PoseJ
    {
    public:
        Array<float, ROBOT_JOINT_NUMBER, 1> joints;
    public:
        PoseJ(float joints[ROBOT_JOINT_NUMBER])
            : joints(Array<float, ROBOT_JOINT_NUMBER, 1>(joints)) {}
        PoseJ(float j1, float j2, float j3, float j4, float j5, float j6)
        {
            joints << j1, j2, j3, j4, j5, j6;
        }
        std::string toString() const;
    };

    template<class T>
    class PosePair
    {
    public:
        T pose1;
        T pose2;
    public:
        PosePair(T pose1, T pose2) : pose1(pose1), pose2(pose2) {}
    };

    template<class T>
    class Trajectory
    {
    public:
        int count;
        std::list<PosePair<T>> pose_array;
    public:
        Trajectory(int count, std::list<PosePair<T>> pose_array) : count(count), pose_array(pose_array) {}
    };

    template<class T>
    class trajectory_pair
    {
    public:
        int start_index;
        int end_index;
        std::vector<T> joints_pose_array_1;
        std::vector<T> joints_pose_array_2;
    public:
        trajectory_pair(int index1, int index2) : start_index(index1), end_index(index2) {}
    };
}

#endif // TRAJECTORY_HPP
