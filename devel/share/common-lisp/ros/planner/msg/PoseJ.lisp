; Auto-generated. Do not edit!


(cl:in-package planner-msg)


;//! \htmlinclude PoseJ.msg.html

(cl:defclass <PoseJ> (roslisp-msg-protocol:ros-message)
  ((joints
    :reader joints
    :initarg :joints
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass PoseJ (<PoseJ>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PoseJ>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PoseJ)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner-msg:<PoseJ> is deprecated: use planner-msg:PoseJ instead.")))

(cl:ensure-generic-function 'joints-val :lambda-list '(m))
(cl:defmethod joints-val ((m <PoseJ>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner-msg:joints-val is deprecated.  Use planner-msg:joints instead.")
  (joints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PoseJ>) ostream)
  "Serializes a message object of type '<PoseJ>"
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'joints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PoseJ>) istream)
  "Deserializes a message object of type '<PoseJ>"
  (cl:setf (cl:slot-value msg 'joints) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'joints)))
    (cl:dotimes (i 6)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PoseJ>)))
  "Returns string type for a message object of type '<PoseJ>"
  "planner/PoseJ")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PoseJ)))
  "Returns string type for a message object of type 'PoseJ"
  "planner/PoseJ")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PoseJ>)))
  "Returns md5sum for a message object of type '<PoseJ>"
  "3c5edcd2b7f6cf1cbc89957aadf54e64")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PoseJ)))
  "Returns md5sum for a message object of type 'PoseJ"
  "3c5edcd2b7f6cf1cbc89957aadf54e64")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PoseJ>)))
  "Returns full string definition for message of type '<PoseJ>"
  (cl:format cl:nil "float32[6] joints~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PoseJ)))
  "Returns full string definition for message of type 'PoseJ"
  (cl:format cl:nil "float32[6] joints~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PoseJ>))
  (cl:+ 0
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'joints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PoseJ>))
  "Converts a ROS message object to a list"
  (cl:list 'PoseJ
    (cl:cons ':joints (joints msg))
))
