;; Auto-generated. Do not edit!


(when (boundp 'planner::PoseJ)
  (if (not (find-package "PLANNER"))
    (make-package "PLANNER"))
  (shadow 'PoseJ (find-package "PLANNER")))
(unless (find-package "PLANNER::POSEJ")
  (make-package "PLANNER::POSEJ"))

(in-package "ROS")
;;//! \htmlinclude PoseJ.msg.html


(defclass planner::PoseJ
  :super ros::object
  :slots (_joints ))

(defmethod planner::PoseJ
  (:init
   (&key
    ((:joints __joints) (make-array 6 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _joints __joints)
   self)
  (:joints
   (&optional __joints)
   (if __joints (setq _joints __joints)) _joints)
  (:serialization-length
   ()
   (+
    ;; float32[6] _joints
    (* 4    6)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[6] _joints
     (dotimes (i 6)
       (sys::poke (elt _joints i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[6] _joints
   (dotimes (i (length _joints))
     (setf (elt _joints i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;;
   self)
  )

(setf (get planner::PoseJ :md5sum-) "3c5edcd2b7f6cf1cbc89957aadf54e64")
(setf (get planner::PoseJ :datatype-) "planner/PoseJ")
(setf (get planner::PoseJ :definition-)
      "float32[6] joints

")



(provide :planner/PoseJ "3c5edcd2b7f6cf1cbc89957aadf54e64")


