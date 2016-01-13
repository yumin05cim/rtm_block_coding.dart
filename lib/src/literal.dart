
library application.literal;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';

class IntegerLiteral extends Block {

  int _a;

  get value => _a;

  set value(int i) => _a = i;

  IntegerLiteral(this._a) {}

  String toPython(int indentLevel) {
    return _a.toString();
  }


  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'value' : value
        },
        nest: () {
        });
  }

  IntegerLiteral.XML(xml.XmlElement node) {
    value = int.parse(node.getAttribute('value'));
  }
}



class RealLiteral extends Block {

  double _a;

  get value => _a;

  set value(double i) => _a = i;

  RealLiteral(this._a) {}

  String toPython(int indentLevel) {
    return _a.toString();
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'value' : value
        },
        nest: () {
        });
  }

  RealLiteral.XML(xml.XmlElement node) {
    value = double.parse(node.getAttribute('value'));
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
    super.element(builder,
        attributes: {
          'value' : value
        },
        nest: () {
        });
  }

  StringLiteral.XML(xml.XmlElement node) {
    value = (node.getAttribute('value'));
  }
}