library application.datatype;



import 'package:xml/xml.dart' as xml;
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

  static bool isPrimitiveType(DataType dt) {
    if (PrimitiveTypes.contains(dt.typename)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isSeqType(String typename) {
    if (typename.startsWith('Timed')) {
      return false;
    }

    if (_cs_typedef_map.keys.contains(typename)) {
      return isSeqType(_cs_typedef_map[typename]);
    }
    if (typename.endsWith('Seq') || typename == '[]') {
      return true;
    }
    return false;
  }

  static var _cs_typedef_map = {
    "RangeList" : "DoubleSeq",
    "ElementGeometryList" : "Geometry3DSeq",
  };

  static List<String> PrimitiveIntegerTypes = [
    "short", "long", "ushort", "ulong"
  ];

  static List<String> PrimitiveRealTypes = [
    "double", "float"
  ];

  static List<String> PrimitiveStringTypes = [
    "String",
  ];

  static List<String> PrimitiveBooleanTypes = [
    "bool",
  ];


  static get PrimitiveTypes {
    var lst = [];
    lst.addAll(PrimitiveIntegerTypes);
    lst.addAll(PrimitiveRealTypes);
    lst.addAll(PrimitiveStringTypes);
    lst.addAll(PrimitiveBooleanTypes);
    return lst;
  }


  static Map<List<String>, String> _cs_map = {
    ["0"] : "0",
    ["[]"] : "[]",
    ["short", "long", "ushort", "ulong"] : "0",
    ["double", "float"] : "0.0",
    ["Long", "ULong", "Short", "UShort", "Char", "UChar"] : "0",
    ["Double", "Float"] : "0.0",
    ["String"] : '""',
    ["bool"] : 'False',
    ["Boolean"] : 'False',
  };

  static Map<String, List<List<String>>> _cs_name_and_zero = {
    "Time" : [["sec", "ulong"], ["usec", "ulong"]],
    "Point2D" : [["x", "double"], ["y", "double"]],
    "Vector2D" : [["x", "double"], ["y", "double"]],
    "Velocity2D" : [["vx", "double"], ["vy", "double"], ["va", "double"]],
    "Acceleration2D" : [["ax", "double"], ["ay", "double"]],
    "Size2D" : [["l", "double"], ["w", "double"]],
    "Point3D" : [["x", "double"], ["y", "double"], ["z", "double"]],
    "Vector3D" : [["x", "double"], ["y", "double"], ["z", "double"]],
    "Velocity3D" : [["vx", "double"], ["vy", "double"], ["vz", "double"], ["vr", "double"], ["vp", "double"], ["va", "double"]],
    "Orientation3D" : [["r", "double"], ["p", "double"], ["y", "double"]],
    "Size3D" : [["l", "double"], ["w", "double"], ["h", "double"]],

    "RangerConfig" : [["minAngle", "double"], ["maxAngle", "double"], ["angularRes", "double"], ["minRange", "double"], ["maxRange", "double"], ["rangeRes", "double"], ["frequency", "double"]],
  };

  static var _cs_tree = {
    "Pose2D" : [["position", "Point2D"], ["heading", "double"]],
    "Geometry2D" : [
      ["pose", "Pose2D"], ["size", "Size2D"]],

    "Pose3D" : [["position", "Point3D"], ["orientation", "Orientation3D"]],
    "Geometry3D" : [["pose", "Pose3D"], ["size", "Size3D"]],
    "RangerGeometry" : [["geometry" , "Geometry3D"], ["elementGeometries", "ElementGeometryList"]],
    "RangeData" : [["tm", "Time"], ["ranges", "RangeList"], ["geometry", "RangerGeometry"], ["config", "RangerConfig"]],
  };

  static var _all_types = [
    "Time",
    "Long", "ULong", "Short", "UShort", "Char", "UChar", "Double", "Float", "String", "Boolean",
    "Point2D", "Vector2D", "Velocity2D", "Acceleration2D", "Size2D", "Point3D", "Vector3D", "Velocity3D", "Orientation3D", "Size3D",
    "Pose2D", "Geometry2D", "Pose3D", "Geometry3D",
    "TimedLong", "TimedULong", "TimedShort", "TimedUShort", "TimedChar", "TimedUChar", "TimedDouble", "TimedFloat", "TimedString", "TimedBoolean",
    "TimedLongSeq", "TimedULongSeq", "TimedShortSeq", "TimedUShortSeq", "TimedCharSeq", "TimedUCharSeq", "TimedDoubleSeq", "TimedFloatSeq", "TimedStringSeq", "TimedBooleanSeq",
    "TimedPoint2D", "TimedVector2D", "TimedVelocity2D", "TimedAcceleration2D", "TimedSize2D", "TimedPoint3D", "TimedVector3D", "TimedVelocity3D", "TimedOrientation3D", "TimedSize3D",
    "RangeConfig", "TimedPose2D", "TimedGeometry2D", "TimedPose3D", "TimedGeometry3D", "RangerGeometry", "RangeData"
  ];

  static get all_types => _all_types;

  bool _cs_support() { return false; }

  static void _sub_access_alt(List<List<String>> ret, String current_alt, String typename) {
    ret.add([current_alt, typename]);

    if(typename.startsWith('Timed')) {
      _sub_access_alt(ret, current_alt + '.tm', "Time");
      _sub_access_alt(ret, current_alt + '.data', typename.substring(5));
    }

    bool end = false;
    _cs_map.keys.forEach(
        (List<String> ks) {
          if (ks.contains(typename)) {
            end=true;
          }
        }
    );
    if (end) {
      return;
    }

    if (_cs_name_and_zero.keys.contains(typename)) {
      _cs_name_and_zero[typename].forEach(
          (List<String> value_pair) {
            ret.add([current_alt + '.' + value_pair.first, value_pair.last]);
          }
      );
    }

    if (_cs_tree.keys.contains(typename)) {
      _cs_tree[typename].forEach(
          (List<String> value_pair) {
            _sub_access_alt(ret, current_alt + '.' + value_pair.first, value_pair.last);
          }
      );
    }

  }

  static String access_alternative_type(String typename, String accessName) {
    var t = null;
    var types = access_alternatives(typename);
    types.forEach((List type) {
      var altName = type[0];
      if (type[0].startsWith('.')) {
        altName = altName.substring(1);
      }
      if (altName == accessName.trim()) {
        t = type[1];
      }
    });
    return t;
  }

  static List<List<String>> access_alternatives(String typename) {
    var ret = [];
    _sub_access_alt(ret, '', typename);

    return ret;
  }


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
              var elem_type = _cs_name_and_zero[key][1];

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

  void buildXML(xml.XmlBuilder builder) {
    builder.element(this.runtimeType.toString(),
        attributes: {
          'typename':  typename,
        },
        nest: () {

        });
  }

  DataType.XML(xml.XmlElement node) {
    typename = node.getAttribute('typename');
  }
}
