
library application.literal;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'condition.dart';


abstract class BasicLiteral<T> extends Block {
  T _value;

  get value => _value;

  set value(T v) {
    _value = v;
  }


  BasicLiteral(this._value) {}

  String toPython(int indentLevel) {
    return _value.toString();
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'value' : value
        },
        nest: () {});
  }

  void loadXML(xml.XmlElement node) {
    value = parse(node.getAttribute('value'));
  }

  T parse(String valueString);
}


class IntegerLiteral extends BasicLiteral<int> {

  IntegerLiteral(int a) : super(a) {}

  int parse(String valueString) => int.parse(valueString);

  IntegerLiteral.XML(xml.XmlElement node) : super(0) {
    loadXML(node);
  }
}



class RealLiteral extends BasicLiteral<double> {

  RealLiteral(double a) : super(a) {}

  double parse(String valueString) => double.parse(valueString);

  RealLiteral.XML(xml.XmlElement node) : super(0.0) {
    loadXML(node);
  }
}



class StringLiteral extends BasicLiteral<String> {
  StringLiteral(String a) : super(a) {}

  String parse(String valueString) => (valueString);

  StringLiteral.XML(xml.XmlElement node) : super("") {
    loadXML(node);
  }

  String toPython(int indentLevel) {
    return "'${_value.toString()}'";
  }
}


class TrueLiteral extends Condition {

  TrueLiteral() {}

  String toPython(int indentLevel) {
    return "True";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {

        });
  }

  TrueLiteral.XML(xml.XmlElement node) {
  }
}

class FalseLiteral extends Condition {

  FalseLiteral() {}

  String toPython(int indentLevel) {
    return "False";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {

        });
  }

  FalseLiteral.XML(xml.XmlElement node) {
  }
}