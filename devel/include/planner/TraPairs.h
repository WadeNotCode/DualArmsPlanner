// Generated by gencpp from file planner/TraPairs.msg
// DO NOT EDIT!


#ifndef PLANNER_MESSAGE_TRAPAIRS_H
#define PLANNER_MESSAGE_TRAPAIRS_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <planner/JointTrajectory.h>

namespace planner
{
template <class ContainerAllocator>
struct TraPairs_
{
  typedef TraPairs_<ContainerAllocator> Type;

  TraPairs_()
    : pairs()  {
    }
  TraPairs_(const ContainerAllocator& _alloc)
    : pairs(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector< ::planner::JointTrajectory_<ContainerAllocator> , typename std::allocator_traits<ContainerAllocator>::template rebind_alloc< ::planner::JointTrajectory_<ContainerAllocator> >> _pairs_type;
  _pairs_type pairs;





  typedef boost::shared_ptr< ::planner::TraPairs_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::planner::TraPairs_<ContainerAllocator> const> ConstPtr;

}; // struct TraPairs_

typedef ::planner::TraPairs_<std::allocator<void> > TraPairs;

typedef boost::shared_ptr< ::planner::TraPairs > TraPairsPtr;
typedef boost::shared_ptr< ::planner::TraPairs const> TraPairsConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::planner::TraPairs_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::planner::TraPairs_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::planner::TraPairs_<ContainerAllocator1> & lhs, const ::planner::TraPairs_<ContainerAllocator2> & rhs)
{
  return lhs.pairs == rhs.pairs;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::planner::TraPairs_<ContainerAllocator1> & lhs, const ::planner::TraPairs_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace planner

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::planner::TraPairs_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::planner::TraPairs_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::planner::TraPairs_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::planner::TraPairs_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::planner::TraPairs_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::planner::TraPairs_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::planner::TraPairs_<ContainerAllocator> >
{
  static const char* value()
  {
    return "c5aeca588befe9ec9f9f74e9608a3492";
  }

  static const char* value(const ::planner::TraPairs_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xc5aeca588befe9ecULL;
  static const uint64_t static_value2 = 0x9f9f74e9608a3492ULL;
};

template<class ContainerAllocator>
struct DataType< ::planner::TraPairs_<ContainerAllocator> >
{
  static const char* value()
  {
    return "planner/TraPairs";
  }

  static const char* value(const ::planner::TraPairs_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::planner::TraPairs_<ContainerAllocator> >
{
  static const char* value()
  {
    return "planner/JointTrajectory[] pairs\n"
"\n"
"================================================================================\n"
"MSG: planner/JointTrajectory\n"
"int32 start_index\n"
"int32 end_index\n"
"planner/PoseJ[] joints_pose_array_1\n"
"planner/PoseJ[] joints_pose_array_2\n"
"\n"
"================================================================================\n"
"MSG: planner/PoseJ\n"
"float32[6] joints\n"
;
  }

  static const char* value(const ::planner::TraPairs_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::planner::TraPairs_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.pairs);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct TraPairs_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::planner::TraPairs_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::planner::TraPairs_<ContainerAllocator>& v)
  {
    s << indent << "pairs[]" << std::endl;
    for (size_t i = 0; i < v.pairs.size(); ++i)
    {
      s << indent << "  pairs[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::planner::JointTrajectory_<ContainerAllocator> >::stream(s, indent + "    ", v.pairs[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // PLANNER_MESSAGE_TRAPAIRS_H
