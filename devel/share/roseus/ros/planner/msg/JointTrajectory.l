;; Auto-generated. Do not edit!


(when (boundp 'planner::JointTrajectory)
  (if (not (find-package "PLANNER"))
    (make-package "PLANNER"))
  (shadow 'JointTrajectory (find-package "PLANNER")))
(unless (find-package "PLANNER::JOINTTRAJECTORY")
  (make-package "PLANNER::JOINTTRAJECTORY"))

(in-package "ROS")
;;//! \htmlinclude JointTrajectory.msg.html


(defclass planner::JointTrajectory
  :super ros::object
  :slots (_start_index _end_index _joints_pose_array_1 _joints_pose_array_2 ))

(defmethod planner::JointTrajectory
  (:init
   (&key
    ((:start_index __start_index) 0)
    ((:end_index __end_index) 0)
    ((:joints_pose_array_1 __joints_pose_array_1) ())
    ((:joints_pose_array_2 __joints_pose_array_2) ())
    )
   (send-super :init)
   (setq _start_index (round __start_index))
   (setq _end_index (round __end_index))
   (setq _joints_pose_array_1 __joints_pose_array_1)
   (setq _joints_pose_array_2 __joints_pose_array_2)
   self)
  (:start_index
   (&optional __start_index)
   (if __start_index (setq _start_index __start_index)) _start_index)
  (:end_index
   (&optional __end_index)
   (if __end_index (setq _end_index __end_index)) _end_index)
  (:joints_pose_array_1
   (&rest __joints_pose_array_1)
   (if (keywordp (car __joints_pose_array_1))
       (send* _joints_pose_array_1 __joints_pose_array_1)
     (progn
       (if __joints_pose_array_1 (setq _joints_pose_array_1 (car __joints_pose_array_1)))
       _joints_pose_array_1)))
  (:joints_pose_array_2
   (&rest __joints_pose_array_2)
   (if (keywordp (car __joints_pose_array_2))
       (send* _joints_pose_array_2 __joints_pose_array_2)
     (progn
       (if __joints_pose_array_2 (setq _joints_pose_array_2 (car __joints_pose_array_2)))
       _joints_pose_array_2)))
  (:serialization-length
   ()
   (+
    ;; int32 _start_index
    4
    ;; int32 _end_index
    4
    ;; planner/PoseJ[] _joints_pose_array_1
    (apply #'+ (send-all _joints_pose_array_1 :serialization-length)) 4
    ;; planner/PoseJ[] _joints_pose_array_2
    (apply #'+ (send-all _joints_pose_array_2 :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _start_index
       (write-long _start_index s)
     ;; int32 _end_index
       (write-long _end_index s)
     ;; planner/PoseJ[] _joints_pose_array_1
     (write-long (length _joints_pose_array_1) s)
     (dolist (elem _joints_pose_array_1)
       (send elem :serialize s)
       )
     ;; planner/PoseJ[] _joints_pose_array_2
     (write-long (length _joints_pose_array_2) s)
     (dolist (elem _joints_pose_array_2)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _start_index
     (setq _start_index (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _end_index
     (setq _end_index (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; planner/PoseJ[] _joints_pose_array_1
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _joints_pose_array_1 (let (r) (dotimes (i n) (push (instance planner::PoseJ :init) r)) r))
     (dolist (elem- _joints_pose_array_1)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; planner/PoseJ[] _joints_pose_array_2
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _joints_pose_array_2 (let (r) (dotimes (i n) (push (instance planner::PoseJ :init) r)) r))
     (dolist (elem- _joints_pose_array_2)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get planner::JointTrajectory :md5sum-) "eec65d949ee76564f104bedfb9feebe1")
(setf (get planner::JointTrajectory :datatype-) "planner/JointTrajectory")
(setf (get planner::JointTrajectory :definition-)
      "int32 start_index
int32 end_index
planner/PoseJ[] joints_pose_array_1
planner/PoseJ[] joints_pose_array_2

================================================================================
MSG: planner/PoseJ
float32[6] joints

")



(provide :planner/JointTrajectory "eec65d949ee76564f104bedfb9feebe1")


