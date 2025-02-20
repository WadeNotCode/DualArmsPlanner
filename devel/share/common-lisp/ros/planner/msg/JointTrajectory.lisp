; Auto-generated. Do not edit!


(cl:in-package planner-msg)


;//! \htmlinclude JointTrajectory.msg.html

(cl:defclass <JointTrajectory> (roslisp-msg-protocol:ros-message)
  ((start_index
    :reader start_index
    :initarg :start_index
    :type cl:integer
    :initform 0)
   (end_index
    :reader end_index
    :initarg :end_index
    :type cl:integer
    :initform 0)
   (joints_pose_array_1
    :reader joints_pose_array_1
    :initarg :joints_pose_array_1
    :type (cl:vector planner-msg:PoseJ)
   :initform (cl:make-array 0 :element-type 'planner-msg:PoseJ :initial-element (cl:make-instance 'planner-msg:PoseJ)))
   (joints_pose_array_2
    :reader joints_pose_array_2
    :initarg :joints_pose_array_2
    :type (cl:vector planner-msg:PoseJ)
   :initform (cl:make-array 0 :element-type 'planner-msg:PoseJ :initial-element (cl:make-instance 'planner-msg:PoseJ))))
)

(cl:defclass JointTrajectory (<JointTrajectory>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JointTrajectory>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JointTrajectory)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner-msg:<JointTrajectory> is deprecated: use planner-msg:JointTrajectory instead.")))

(cl:ensure-generic-function 'start_index-val :lambda-list '(m))
(cl:defmethod start_index-val ((m <JointTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner-msg:start_index-val is deprecated.  Use planner-msg:start_index instead.")
  (start_index m))

(cl:ensure-generic-function 'end_index-val :lambda-list '(m))
(cl:defmethod end_index-val ((m <JointTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner-msg:end_index-val is deprecated.  Use planner-msg:end_index instead.")
  (end_index m))

(cl:ensure-generic-function 'joints_pose_array_1-val :lambda-list '(m))
(cl:defmethod joints_pose_array_1-val ((m <JointTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner-msg:joints_pose_array_1-val is deprecated.  Use planner-msg:joints_pose_array_1 instead.")
  (joints_pose_array_1 m))

(cl:ensure-generic-function 'joints_pose_array_2-val :lambda-list '(m))
(cl:defmethod joints_pose_array_2-val ((m <JointTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner-msg:joints_pose_array_2-val is deprecated.  Use planner-msg:joints_pose_array_2 instead.")
  (joints_pose_array_2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JointTrajectory>) ostream)
  "Serializes a message object of type '<JointTrajectory>"
  (cl:let* ((signed (cl:slot-value msg 'start_index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'end_index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'joints_pose_array_1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'joints_pose_array_1))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'joints_pose_array_2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'joints_pose_array_2))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JointTrajectory>) istream)
  "Deserializes a message object of type '<JointTrajectory>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'start_index) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'end_index) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'joints_pose_array_1) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'joints_pose_array_1)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'planner-msg:PoseJ))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'joints_pose_array_2) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'joints_pose_array_2)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'planner-msg:PoseJ))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JointTrajectory>)))
  "Returns string type for a message object of type '<JointTrajectory>"
  "planner/JointTrajectory")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JointTrajectory)))
  "Returns string type for a message object of type 'JointTrajectory"
  "planner/JointTrajectory")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JointTrajectory>)))
  "Returns md5sum for a message object of type '<JointTrajectory>"
  "eec65d949ee76564f104bedfb9feebe1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JointTrajectory)))
  "Returns md5sum for a message object of type 'JointTrajectory"
  "eec65d949ee76564f104bedfb9feebe1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JointTrajectory>)))
  "Returns full string definition for message of type '<JointTrajectory>"
  (cl:format cl:nil "int32 start_index~%int32 end_index~%planner/PoseJ[] joints_pose_array_1~%planner/PoseJ[] joints_pose_array_2~%~%================================================================================~%MSG: planner/PoseJ~%float32[6] joints~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JointTrajectory)))
  "Returns full string definition for message of type 'JointTrajectory"
  (cl:format cl:nil "int32 start_index~%int32 end_index~%planner/PoseJ[] joints_pose_array_1~%planner/PoseJ[] joints_pose_array_2~%~%================================================================================~%MSG: planner/PoseJ~%float32[6] joints~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JointTrajectory>))
  (cl:+ 0
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'joints_pose_array_1) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'joints_pose_array_2) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JointTrajectory>))
  "Converts a ROS message object to a list"
  (cl:list 'JointTrajectory
    (cl:cons ':start_index (start_index msg))
    (cl:cons ':end_index (end_index msg))
    (cl:cons ':joints_pose_array_1 (joints_pose_array_1 msg))
    (cl:cons ':joints_pose_array_2 (joints_pose_array_2 msg))
))
