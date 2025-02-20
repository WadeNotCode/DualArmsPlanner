; Auto-generated. Do not edit!


(cl:in-package planner-msg)


;//! \htmlinclude TraPairs.msg.html

(cl:defclass <TraPairs> (roslisp-msg-protocol:ros-message)
  ((pairs
    :reader pairs
    :initarg :pairs
    :type (cl:vector planner-msg:JointTrajectory)
   :initform (cl:make-array 0 :element-type 'planner-msg:JointTrajectory :initial-element (cl:make-instance 'planner-msg:JointTrajectory))))
)

(cl:defclass TraPairs (<TraPairs>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TraPairs>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TraPairs)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner-msg:<TraPairs> is deprecated: use planner-msg:TraPairs instead.")))

(cl:ensure-generic-function 'pairs-val :lambda-list '(m))
(cl:defmethod pairs-val ((m <TraPairs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner-msg:pairs-val is deprecated.  Use planner-msg:pairs instead.")
  (pairs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TraPairs>) ostream)
  "Serializes a message object of type '<TraPairs>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pairs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pairs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TraPairs>) istream)
  "Deserializes a message object of type '<TraPairs>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pairs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pairs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'planner-msg:JointTrajectory))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TraPairs>)))
  "Returns string type for a message object of type '<TraPairs>"
  "planner/TraPairs")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TraPairs)))
  "Returns string type for a message object of type 'TraPairs"
  "planner/TraPairs")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TraPairs>)))
  "Returns md5sum for a message object of type '<TraPairs>"
  "c5aeca588befe9ec9f9f74e9608a3492")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TraPairs)))
  "Returns md5sum for a message object of type 'TraPairs"
  "c5aeca588befe9ec9f9f74e9608a3492")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TraPairs>)))
  "Returns full string definition for message of type '<TraPairs>"
  (cl:format cl:nil "planner/JointTrajectory[] pairs~%~%================================================================================~%MSG: planner/JointTrajectory~%int32 start_index~%int32 end_index~%planner/PoseJ[] joints_pose_array_1~%planner/PoseJ[] joints_pose_array_2~%~%================================================================================~%MSG: planner/PoseJ~%float32[6] joints~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TraPairs)))
  "Returns full string definition for message of type 'TraPairs"
  (cl:format cl:nil "planner/JointTrajectory[] pairs~%~%================================================================================~%MSG: planner/JointTrajectory~%int32 start_index~%int32 end_index~%planner/PoseJ[] joints_pose_array_1~%planner/PoseJ[] joints_pose_array_2~%~%================================================================================~%MSG: planner/PoseJ~%float32[6] joints~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TraPairs>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pairs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TraPairs>))
  "Converts a ROS message object to a list"
  (cl:list 'TraPairs
    (cl:cons ':pairs (pairs msg))
))
