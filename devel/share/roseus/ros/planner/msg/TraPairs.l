;; Auto-generated. Do not edit!


(when (boundp 'planner::TraPairs)
  (if (not (find-package "PLANNER"))
    (make-package "PLANNER"))
  (shadow 'TraPairs (find-package "PLANNER")))
(unless (find-package "PLANNER::TRAPAIRS")
  (make-package "PLANNER::TRAPAIRS"))

(in-package "ROS")
;;//! \htmlinclude TraPairs.msg.html


(defclass planner::TraPairs
  :super ros::object
  :slots (_pairs ))

(defmethod planner::TraPairs
  (:init
   (&key
    ((:pairs __pairs) ())
    )
   (send-super :init)
   (setq _pairs __pairs)
   self)
  (:pairs
   (&rest __pairs)
   (if (keywordp (car __pairs))
       (send* _pairs __pairs)
     (progn
       (if __pairs (setq _pairs (car __pairs)))
       _pairs)))
  (:serialization-length
   ()
   (+
    ;; planner/JointTrajectory[] _pairs
    (apply #'+ (send-all _pairs :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; planner/JointTrajectory[] _pairs
     (write-long (length _pairs) s)
     (dolist (elem _pairs)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; planner/JointTrajectory[] _pairs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pairs (let (r) (dotimes (i n) (push (instance planner::JointTrajectory :init) r)) r))
     (dolist (elem- _pairs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get planner::TraPairs :md5sum-) "c5aeca588befe9ec9f9f74e9608a3492")
(setf (get planner::TraPairs :datatype-) "planner/TraPairs")
(setf (get planner::TraPairs :definition-)
      "planner/JointTrajectory[] pairs

================================================================================
MSG: planner/JointTrajectory
int32 start_index
int32 end_index
planner/PoseJ[] joints_pose_array_1
planner/PoseJ[] joints_pose_array_2

================================================================================
MSG: planner/PoseJ
float32[6] joints

")



(provide :planner/TraPairs "c5aeca588befe9ec9f9f74e9608a3492")


