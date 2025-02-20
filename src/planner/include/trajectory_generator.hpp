#include "trajectory.hpp"
#include <cmath>

namespace Generator
{
    class Circle
    {
    private:
        float angle_diff;
        float ridius;
        float center[3];
        float direction[3];
        float start_angle;
        float end_angle;

    public:
        std::vector<RobotCT::PoseV> circle_posev;
        Circle(float center_[3], float ridius, float direction_[3], float angle_diff, float start_angle, float end_angle) : 
            ridius(ridius), angle_diff(angle_diff), start_angle(start_angle), end_angle(end_angle)
        {
            circle_posev.clear();
            for(int i=0; i<3; i++)
            {
                center[i] = center_[i];
                direction[i] = direction_[i];
            }
            Eigen::Vector3f circle_direction(direction[0],direction[1],direction[2]);
            Eigen::Quaternionf q(calculate_base_quaternionf(circle_direction));
            float angle = start_angle;

            do
            {
                Eigen::Quaternionf p(0, std::cos(angle) ,std::sin(angle) , 0);
                Eigen::Quaternionf p_ = q*p*q.conjugate();
                Eigen::Vector3f relative_position(ridius*p_.x(), ridius*p_.y(), ridius*p_.z());                
                Eigen::Vector3f position(center[0] + ridius*p_.x(), center[1] + ridius*p_.y(), center[2] + ridius*p_.z());
                Eigen::Vector3f base_vector(0.0f, 0.0f, 1.0f);
                Eigen::Quaternionf q_p_ = Eigen::Quaternionf::FromTwoVectors(base_vector, -relative_position);
                RobotCT::PoseV posev(position,q_p_);
                circle_posev.push_back(posev);
                angle = angle + angle_diff;
            } while (angle < end_angle);

            if (angle != end_angle)
            {
                angle = end_angle;
                Eigen::Vector3f position(std::cos(angle) + center[0],std::sin(angle) + center[1], center[2]);
                Eigen::Quaternionf p(calculate_base_quaternionf(position));
                p = p*q;
                RobotCT::PoseV posev(position,p);
                circle_posev.push_back(posev);
            }
            
        }
        Eigen::Quaternionf calculate_base_quaternionf(Eigen::Vector3f direction)
        {
            Eigen::Vector3f base(0.0f, 0.0f, 1.0f);
            Eigen::Quaternionf q_ = Eigen::Quaternionf::FromTwoVectors(base, direction);
            return q_;
        }

    };
}
