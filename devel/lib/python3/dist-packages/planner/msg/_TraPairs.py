# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from planner/TraPairs.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import planner.msg

class TraPairs(genpy.Message):
  _md5sum = "c5aeca588befe9ec9f9f74e9608a3492"
  _type = "planner/TraPairs"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """planner/JointTrajectory[] pairs

================================================================================
MSG: planner/JointTrajectory
int32 start_index
int32 end_index
planner/PoseJ[] joints_pose_array_1
planner/PoseJ[] joints_pose_array_2

================================================================================
MSG: planner/PoseJ
float32[6] joints
"""
  __slots__ = ['pairs']
  _slot_types = ['planner/JointTrajectory[]']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       pairs

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(TraPairs, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.pairs is None:
        self.pairs = []
    else:
      self.pairs = []

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      length = len(self.pairs)
      buff.write(_struct_I.pack(length))
      for val1 in self.pairs:
        _x = val1
        buff.write(_get_struct_2i().pack(_x.start_index, _x.end_index))
        length = len(val1.joints_pose_array_1)
        buff.write(_struct_I.pack(length))
        for val2 in val1.joints_pose_array_1:
          buff.write(_get_struct_6f().pack(*val2.joints))
        length = len(val1.joints_pose_array_2)
        buff.write(_struct_I.pack(length))
        for val2 in val1.joints_pose_array_2:
          buff.write(_get_struct_6f().pack(*val2.joints))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      if self.pairs is None:
        self.pairs = None
      end = 0
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      self.pairs = []
      for i in range(0, length):
        val1 = planner.msg.JointTrajectory()
        _x = val1
        start = end
        end += 8
        (_x.start_index, _x.end_index,) = _get_struct_2i().unpack(str[start:end])
        start = end
        end += 4
        (length,) = _struct_I.unpack(str[start:end])
        val1.joints_pose_array_1 = []
        for i in range(0, length):
          val2 = planner.msg.PoseJ()
          start = end
          end += 24
          val2.joints = _get_struct_6f().unpack(str[start:end])
          val1.joints_pose_array_1.append(val2)
        start = end
        end += 4
        (length,) = _struct_I.unpack(str[start:end])
        val1.joints_pose_array_2 = []
        for i in range(0, length):
          val2 = planner.msg.PoseJ()
          start = end
          end += 24
          val2.joints = _get_struct_6f().unpack(str[start:end])
          val1.joints_pose_array_2.append(val2)
        self.pairs.append(val1)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      length = len(self.pairs)
      buff.write(_struct_I.pack(length))
      for val1 in self.pairs:
        _x = val1
        buff.write(_get_struct_2i().pack(_x.start_index, _x.end_index))
        length = len(val1.joints_pose_array_1)
        buff.write(_struct_I.pack(length))
        for val2 in val1.joints_pose_array_1:
          buff.write(val2.joints.tostring())
        length = len(val1.joints_pose_array_2)
        buff.write(_struct_I.pack(length))
        for val2 in val1.joints_pose_array_2:
          buff.write(val2.joints.tostring())
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      if self.pairs is None:
        self.pairs = None
      end = 0
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      self.pairs = []
      for i in range(0, length):
        val1 = planner.msg.JointTrajectory()
        _x = val1
        start = end
        end += 8
        (_x.start_index, _x.end_index,) = _get_struct_2i().unpack(str[start:end])
        start = end
        end += 4
        (length,) = _struct_I.unpack(str[start:end])
        val1.joints_pose_array_1 = []
        for i in range(0, length):
          val2 = planner.msg.PoseJ()
          start = end
          end += 24
          val2.joints = numpy.frombuffer(str[start:end], dtype=numpy.float32, count=6)
          val1.joints_pose_array_1.append(val2)
        start = end
        end += 4
        (length,) = _struct_I.unpack(str[start:end])
        val1.joints_pose_array_2 = []
        for i in range(0, length):
          val2 = planner.msg.PoseJ()
          start = end
          end += 24
          val2.joints = numpy.frombuffer(str[start:end], dtype=numpy.float32, count=6)
          val1.joints_pose_array_2.append(val2)
        self.pairs.append(val1)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_2i = None
def _get_struct_2i():
    global _struct_2i
    if _struct_2i is None:
        _struct_2i = struct.Struct("<2i")
    return _struct_2i
_struct_6f = None
def _get_struct_6f():
    global _struct_6f
    if _struct_6f is None:
        _struct_6f = struct.Struct("<6f")
    return _struct_6f
