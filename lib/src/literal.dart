
library application.literal;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';

class Integer extends Block {

  int _a;

  get value => _a;

  set value(int i) => _a = i;

  Integer(this._a) {}

  String toPython(int indentLevel) {
    return _a.toString();
  }


  void buildXML(xml.XmlBuilder builder) {
    builder.element('Integer',
        attributes: {
          'value' : value
        },
        nest: () {
        });
  }
}

class StringLiteral extends Block {

  String _a;

  get value => _a;

  set value(String s) => _a = s;

  StringLiteral(this._a) {}

  String toPython(int indentLevel) {
    return "'${_a.toString()}'";
  }


  void buildXML(xml.XmlBuilder builder) {
    builder.element('StringLiteral',
        attributes: {
          'value' : value
        },
        nest: () {
        });
  }
}