// Auto-generated. Do not edit!

// (in-package planner.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let JointTrajectory = require('./JointTrajectory.js');

//-----------------------------------------------------------

class TraPairs {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pairs = null;
    }
    else {
      if (initObj.hasOwnProperty('pairs')) {
        this.pairs = initObj.pairs
      }
      else {
        this.pairs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TraPairs
    // Serialize message field [pairs]
    // Serialize the length for message field [pairs]
    bufferOffset = _serializer.uint32(obj.pairs.length, buffer, bufferOffset);
    obj.pairs.forEach((val) => {
      bufferOffset = JointTrajectory.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TraPairs
    let len;
    let data = new TraPairs(null);
    // Deserialize message field [pairs]
    // Deserialize array length for message field [pairs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.pairs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.pairs[i] = JointTrajectory.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.pairs.forEach((val) => {
      length += JointTrajectory.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner/TraPairs';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c5aeca588befe9ec9f9f74e9608a3492';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    planner/JointTrajectory[] pairs
    
    ================================================================================
    MSG: planner/JointTrajectory
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
    const resolved = new TraPairs(null);
    if (msg.pairs !== undefined) {
      resolved.pairs = new Array(msg.pairs.length);
      for (let i = 0; i < resolved.pairs.length; ++i) {
        resolved.pairs[i] = JointTrajectory.Resolve(msg.pairs[i]);
      }
    }
    else {
      resolved.pairs = []
    }

    return resolved;
    }
};

module.exports = TraPairs;
