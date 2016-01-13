
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

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'Integer');
    }
    return false;
  }

  Integer.XML(xml.XmlElement node) {
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
    builder.element('Real',
        attributes: {
          'value' : value
        },
        nest: () {
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'RealLiteral');
    }
    return false;
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
    builder.element('StringLiteral',
        attributes: {
          'value' : value
        },
        nest: () {
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'StringLiteral');
    }
    return false;
  }

  StringLiteral.XML(xml.XmlElement node) {
    value = (node.getAttribute('value'));
  }
}