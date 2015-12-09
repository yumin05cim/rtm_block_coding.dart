library application.datatype;



import 'dart:core';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';

class DataType extends Block {

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

  static var _cs_map = {
    ["0"] : "0",
    ["[]"] : "[]",
    ["Long", "ULong", "Short", "UShort", "Char", "UChar"] : "0",
    ["Double", "Float"] : "0.0",
    ["String"] : '""'
  };

  static var _cs_name_and_zero = {
    "Time" : 2,
    "Point2D" : 2,
    "Vector2D" : 2,
    "Velocity2D" : 3,
    "Acceleration2D" : 2,
    "Size2D" : 2,

    "Point3D" : 3,
    "Vector3D" : 3,
    "Velocity3D" : 6,
    "Orientation3D" : 3,
    "Size3D" : 3,
  };

  static var _cs_tree = {
    "Pose2D" : ["Point2D", "0"],
  };

  bool _cs_support() { return false; }


  static String _cs(String tn) {
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
            int num_zero = _cs_name_and_zero[key];
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
              return_value += _cs(values[i]);
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
      return "not_supported_data_type";
    }

    return return_value;
  }
}
