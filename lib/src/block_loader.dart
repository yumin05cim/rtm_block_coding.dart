library block_loader;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'dart:mirrors';
import 'block.dart';
import 'literal.dart';
import 'basic_operator.dart';
import 'condition.dart';
import 'datatype.dart';
import 'flow_control.dart';
import 'inport.dart';
import 'io.dart';
import 'outport.dart';

class BlockLoader {

  static List<Type> blockTypes = [
    IntegerLiteral, StringLiteral, RealLiteral,
    SetVariable, Variable, Add, Subtract, Multiply, Div,
    Equals, SmallerThan, SmallerThanOrEquals, LargerThan, LargerThanOrEquals, Not, TrueLiteral, FalseLiteral,
    DataType,
    If, While, Break,
    Print,
    AccessInPort, AddInPort, ReadInPort,
    AccessOutPort, AddOutPort, WriteOutPort,
  ];

  static bool isClassXmlNode(xml.XmlElement node, Type type) {
    return (node.name.toString() == type.toString());
  }

  static Block parseBlock(xml.XmlElement node) {
    var elem = null;
    blockTypes.forEach((Type T) {
      if(isClassXmlNode(node, T)) {
        elem = reflectClass(T).newInstance(new Symbol('XML'), [node]).reflectee;
      }
    });

    return elem;
  }

}
