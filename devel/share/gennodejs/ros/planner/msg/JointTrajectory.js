// Auto-generated. Do not edit!

// (in-package planner.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PoseJ = require('./PoseJ.js');

//-----------------------------------------------------------

class JointTrajectory {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.start_index = null;
      this.end_index = null;
      this.joints_pose_array_1 = null;
      this.joints_pose_array_2 = null;
    }
    else {
      if (initObj.hasOwnProperty('start_index')) {
        this.start_index = initObj.start_index
      }
      else {
        this.start_index = 0;
      }
      if (initObj.hasOwnProperty('end_index')) {
        this.end_index = initObj.end_index
      }
      else {
        this.end_index = 0;
      }
      if (initObj.hasOwnProperty('joints_pose_array_1')) {
        this.joints_pose_array_1 = initObj.joints_pose_array_1
      }
      else {
        this.joints_pose_array_1 = [];
      }
      if (initObj.hasOwnProperty('joints_pose_array_2')) {
        this.joints_pose_array_2 = initObj.joints_pose_array_2
      }
      else {
        this.joints_pose_array_2 = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type JointTrajectory
    // Serialize message field [start_index]
    bufferOffset = _serializer.int32(obj.start_index, buffer, bufferOffset);
    // Serialize message field [end_index]
    bufferOffset = _serializer.int32(obj.end_index, buffer, bufferOffset);
    // Serialize message field [joints_pose_array_1]
    // Serialize the length for message field [joints_pose_array_1]
    bufferOffset = _serializer.uint32(obj.joints_pose_array_1.length, buffer, bufferOffset);
    obj.joints_pose_array_1.forEach((val) => {
      bufferOffset = PoseJ.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [joints_pose_array_2]
    // Serialize the length for message field [joints_pose_array_2]
    bufferOffset = _serializer.uint32(obj.joints_pose_array_2.length, buffer, bufferOffset);
    obj.joints_pose_array_2.forEach((val) => {
      bufferOffset = PoseJ.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type JointTrajectory
    let len;
    let data = new JointTrajectory(null);
    // Deserialize message field [start_index]
    data.start_index = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [end_index]
    data.end_index = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [joints_pose_array_1]
    // Deserialize array length for message field [joints_pose_array_1]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.joints_pose_array_1 = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.joints_pose_array_1[i] = PoseJ.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [joints_pose_array_2]
    // Deserialize array length for message field [joints_pose_array_2]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.joints_pose_array_2 = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.joints_pose_array_2[i] = PoseJ.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 24 * object.joints_pose_array_1.length;
    length += 24 * object.joints_pose_array_2.length;
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner/JointTrajectory';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eec65d949ee76564f104bedfb9feebe1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 start_index
    int32 end_index
    planner/PoseJ[] joints_pose_array_1
    planner/PoseJ[] joints_pose_array_2
    
    ================================================================================
    MSG: planner/PoseJ
    float32[6] joints
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new JointTrajectory(null);
    if (msg.start_index !== undefined) {
      resolved.start_index = msg.start_index;
    }
    else {
      resolved.start_index = 0
    }

    if (msg.end_index !== undefined) {
      resolved.end_index = msg.end_index;
    }
    else {
      resolved.end_index = 0
    }

    if (msg.joints_pose_array_1 !== undefined) {
      resolved.joints_pose_array_1 = new Array(msg.joints_pose_array_1.length);
      for (let i = 0; i < resolved.joints_pose_array_1.length; ++i) {
        resolved.joints_pose_array_1[i] = PoseJ.Resolve(msg.joints_pose_array_1[i]);
      }
    }
    else {
      resolved.joints_pose_array_1 = []
    }

    if (msg.joints_pose_array_2 !== undefined) {
      resolved.joints_pose_array_2 = new Array(msg.joints_pose_array_2.length);
      for (let i = 0; i < resolved.joints_pose_array_2.length; ++i) {
        resolved.joints_pose_array_2[i] = PoseJ.Resolve(msg.joints_pose_array_2[i]);
      }
    }
    else {
      resolved.joints_pose_array_2 = []
    }

    return resolved;
    }
};

module.exports = JointTrajectory;
