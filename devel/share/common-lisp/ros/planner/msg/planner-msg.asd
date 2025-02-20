
(cl:in-package :asdf)

(defsystem "planner-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "JointTrajectory" :depends-on ("_package_JointTrajectory"))
    (:file "_package_JointTrajectory" :depends-on ("_package"))
    (:file "PoseJ" :depends-on ("_package_PoseJ"))
    (:file "_package_PoseJ" :depends-on ("_package"))
    (:file "TraPairs" :depends-on ("_package_TraPairs"))
    (:file "_package_TraPairs" :depends-on ("_package"))
  ))