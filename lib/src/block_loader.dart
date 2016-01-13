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
    SetValue, Variable, Add, Subtract, Multiply,
    Equals, SmallerThan, SmallerThanOrEquals, LargerThan, LargerThanOrEquals, Not, TrueLiteral, FalseLiteral,
    DataType,
    If, While, Break,
    Print,
    AccessInPort, AddInPort, ReadInPort,
    OutPortData, AddOutPort, OutPortWrite,
  ];

  static Block parseBlock(xml.XmlNode node) {
    print('parseBlock:'+node.toString());
    var elem = null;
    blockTypes.forEach((Type T) {
      ClassMirror tMirror = reflectClass(T);
      if(tMirror.invoke(new Symbol('isClassXmlNode'), [node]).reflectee) {
        elem = tMirror.newInstance(new Symbol('XML'), [node]).reflectee;
      } else {
      }
    });

    return elem;
  }

}
