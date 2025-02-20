#include "trajectory.hpp"
#include "solver.hpp"
#include <math.h>

struct IndexedDistance
{
    float value;
    size_t index;
};

bool compareIndexedDistances(const IndexedDistance& a, const IndexedDistance& b) 
{
    return a.value < b.value;
}

float PoseJ_distance(const RobotCT::PoseJ & pose1, const RobotCT::PoseJ & pose2)
{
    float distance = 0;
    for (int i = 0; i < 6 ; i++)
        distance = distance + abs(pose1.joints[i] - pose2.joints[i]);
    return distance;
}

int joints_choose(RobotCT::PoseJ & pose, std::vector<RobotCT::PoseJ> & joints_1, std::vector<RobotCT::PoseJ> & joints_2 ,int k)
{
    float lambda = 0.5;
    std::vector<float> distance_1;
    for (int i = 0; i < joints_1.size(); i++)
    {
        float dis12value = PoseJ_distance(joints_1[i], joints_2[0]);
        for (int j = 1; j < joints_2.size(); j++)
        {
            float dis12 = PoseJ_distance(joints_1[i], joints_2[j]);
            if (dis12 < dis12value)
                dis12value = dis12;
        }
        float dis01 = PoseJ_distance(pose, joints_1[i]) + lambda * dis12value;
        distance_1.push_back(dis01);
    }

    std::vector<IndexedDistance> indexedVec;
    for (int i = 0; i < joints_1.size(); ++i) 
    {
        IndexedDistance a;
        a.index = i;
        a.value = distance_1[i];
        indexedVec.push_back(a);
    }
    // 对带有索引的结构体数组进行排序
    std::sort(indexedVec.begin(), indexedVec.end(), compareIndexedDistances);
    return indexedVec[k].index;
}

class IK
{
public:
    RobotCT::PoseV pose;
    std::vector<double> matrix;
    std::vector<double> trans_matrix;
    IK(const RobotCT::PoseV& p, std::vector<double> & trans_matrix_): pose(p) , matrix(16, 0.0) , trans_matrix(16,0.0) 
    {
        for (int i=0; i<12;i++)
            trans_matrix[i] = trans_matrix_[i];
        trans_matrix[15] = 1.0;
    }
    void toMatrix()
    {
        double w = double(pose.orientation.w());
        double x = double(pose.orientation.x());
        double y = double(pose.orientation.y());
        double z = double(pose.orientation.z());
        double matrix_[16] = {1 - 2*y*y - 2*z*z, 2*x*y - 2*w*z, 2*x*z + 2*w*y, pose.position.x(),
                2*x*y + 2*w*z, 1 - 2*x*x - 2*z*z, 2*y*z - 2*w*x, pose.position.y(),
                2*x*z - 2*w*y, 2*y*z + 2*w*x, 1 - 2*x*x - 2*y*y, pose.position.z(), 0.0, 0.0, 0.0, 1.0};
        for(int i=0;i<4;i++)
        {
            for(int j=0;j<4;j++)
            {
                for(int k = 0;k < 4;k++)
                    matrix[4*i + j] = matrix[4*i + j] + trans_matrix[4*i+k]*matrix_[j+4*k];
            }
        }
    }

    // 求解给定位置下的逆运动学
    bool IK_solve(std::vector<RobotCT::PoseJ> & valid_solutions)
    {
        toMatrix();
        IkSolutionList<IkReal> solutions;
        std::vector<IkReal> vfree(GetNumFreeParameters());
        IkReal eerot[9],eetrans[3];
        eerot[0] = matrix[0]; eerot[1] = matrix[1]; eerot[2] = matrix[2]; eetrans[0] = matrix[3];
        eerot[3] = matrix[4]; eerot[4] = matrix[5]; eerot[5] = matrix[6]; eetrans[1] = matrix[7];
        eerot[6] = matrix[8]; eerot[7] = matrix[9]; eerot[8] = matrix[10]; eetrans[2] = matrix[11];
        // std::cout << eerot[0] << " " << eerot[1]  << " " << eerot[2]  <<" " << eetrans[0] << std::endl;
        // std::cout << eerot[3] << " " << eerot[4]  << " " << eerot[5]  <<" " << eetrans[1] << std::endl;
        // std::cout << eerot[6] << " " << eerot[7]  << " " << eerot[8]  <<" " << eetrans[2] << std::endl;
        bool bSuccess = ComputeIk(eetrans, eerot, NULL, solutions);
        if( !bSuccess ) 
        {
            std::cout<<"Failed to get ik solution\n";
        }
        std::vector<IkReal> solvalues(GetNumJoints());
        float joint[6] = {0};
        RobotCT::PoseJ solution(joint);
        for(int i = 0; i < solutions.GetNumSolutions(); ++i) 
        {
            const IkSolutionBase<IkReal>& sol = solutions.GetSolution(i);
            sol.GetSolution(&solvalues[0], NULL);
            int check_num = 0;
            for(int j = 0; j < solvalues.size(); ++j)
            {
                if(check_limit(j,solvalues[j]))
                {
                    solution.joints[j] = solvalues[j];
                    check_num = check_num + 1;
                }
                else
                {
                    break;
                }
            }
            if(check_num==6)
                valid_solutions.push_back(solution);
        }
        if (valid_solutions.size() < 1)
            return false;
        return true;
    }

    bool check_limit(int j, const float joint_value)
    {
        float lower;
        float upper;
        switch (j)
        {
        case 0:
            lower=-1.57;
            upper=1.57;
            break;
        case 1:
            lower=-1.7453;
            upper=2.7925;
            break;
        case 2:
            lower=-1.4788;
            upper=4.1888;
            break;
        case 3:
            lower=-3.4907;
            upper=3.4907;
            break;
        case 4:
            lower=-3.14;
            upper=3.14;
            break;
        case 5:
            lower=-3.14;
            upper=3.14;
            break;
        default:
            break;
        }
        if((joint_value > upper)||(joint_value < lower))
        {
            std::cout << "Joint" << j << "'s value is " << joint_value << " ,over the limit area from " << lower << " to " << upper << std::endl;
            return false;
        }
        return true;
    }

};