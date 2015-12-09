library application.datatype;



import 'dart:core';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';

class DataType {

  String typename;

  DataType.TimedLong() {
    typename = 'TimedLong';
  }

  DataType.fromTypeName(String typeName) {
    typename = typeName;
  }

  String constructorString() {
    return _cs(typename);
  }


  static var _cs_typedef_map = {
    "RangeList" : "DoubleSeq",
    "ElementGeometryList" : "Geometry3DSeq",
  };

  static var _cs_map = {
    ["0"] : "0",
    ["[]"] : "[]",
    ["Long", "ULong", "Short", "UShort", "Char", "UChar"] : "0",
    ["Double", "Float"] : "0.0",
    ["String"] : '""'
  };

  static var _cs_name_and_zero = {
    "Time" : ["sec", "usec"],
    "Point2D" : ["x", "y"],
    "Vector2D" : ["x", "y"],
    "Velocity2D" : ["vx", "vy", "va"],
    "Acceleration2D" : ["ax", "ay"],
    "Size2D" : ["l", "w"],
    "Point3D" : ["x", "y", "z"],
    "Vector3D" : ["x", "y", "z"],
    "Velocity3D" : ["vx", "vy", "vz", "vr", "vp", "va"],
    "Orientation3D" : ["r", "p", "y"],
    "Size3D" : ["l", "w", "h"],

    "RangerConfig" : ["minAngle", "maxAngle", "angularRes", "minRange", "maxRange", "rangeRes", "frequency"],
  };

  static var _cs_tree = {
    "Pose2D" : [["position", "Point2D"], ["heading", "0"]],
    "Geometry2D" : [
      ["pose", "Pose2D"], ["size", "Size2D"]],

    "Pose3D" : [["position", "Point3D"], ["orientation", "Orientation3D"]],
    "Geometry3D" : [["pose", "Pose3D"], ["size", "Size3D"]],
    "RangerGeometry" : [["geometry" , "Geometry3D"], ["elementGeometries", "ElementGeometryList"]],
    "RangeData" : [["tm", "Time"], ["ranges", "RangeList"], ["geometry", "RangerGeometry"], ["config", "RangerConfig"]],
  };

  bool _cs_support() { return false; }


  static String _cs(String tn) {
    var retval = null;
    _cs_typedef_map.keys.forEach(
        (var key) {
          if (tn == key) {
            retval = _cs(_cs_typedef_map[key]);
          }
        }
    );
    if (retval != null) {
      return retval;
    }


    if (tn.startsWith('Timed')) {
      String tim = _cs("Time");
      String temp = _cs(tn.substring(5));
      return 'RTC.${tn}(${tim}, ${temp})';
    };

    if (tn.endsWith('Seq')) {
      return '[]';
    }

    String return_value = null;
    _cs_map.keys.forEach(
      (var keys) {
        keys.forEach(
          (var key) {
            if (tn == key) {
              return_value = _cs_map[keys];
            }
          }
        );
      }
    );

    if (return_value != null) {
      return return_value;
    }

    _cs_name_and_zero.keys.forEach(
        (var key) {
          if (tn == key) {
            return_value = "RTC.${tn}(";
            int num_zero = _cs_name_and_zero[key].length;
            for(var i = 0;i < num_zero;i++) {
              return_value += "0";
              if (i != num_zero-1) {
                return_value += ", ";
              } else {
                return_value += ")";
              }
            }
          }

        }
    );

    _cs_tree.keys.forEach(
        (var key) {
          if (tn == key) {
            return_value = "RTC.${tn}(";
            var values = _cs_tree[key];
            int num = values.length;
            for(int i = 0;i < num;i++) {
              return_value += _cs(values[i][1]);
              if (i != num-1) {
                return_value += ", ";
              } else {
                return_value += ")";
              }
            }

          }
        }
    );


    if (return_value == null) {
      return "not_supported_data_type(${tn})";
    }

    return return_value;
  }
}
