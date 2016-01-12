
library application.condition;
import 'block.dart';


import 'package:xml/xml.dart' as xml;

abstract class Condition extends Block {

  Condition() {}

  /*
  String toPython(int indentLevel) {
    return _block.toPython(0);
  }
  */
}

class Equals extends Condition {
  Block _a;
  Block _b;

  get a => _a;
  get b => _b;

  Equals(this._a, this._b) {
  }

  String toPython(int indentLevel) {
    return "${_a.toPython(0)} == ${_b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Equals',
        attributes: {
        },
        nest : () {
          builder.element('a',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('b',
              nest : () {
                b.buildXML(builder);
              });
        });
  }
}

class TrueLiteral extends Condition {

  TrueLiteral() {}

  String toPython(int indentLevel) {
    return "True";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('TrueLiteral',
        attributes: {
        },
        nest: () {

        });
  }
}

class FalseLiteral extends Condition {

  FalseLiteral() {}

  String toPython(int indentLevel) {
    return "False";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('FalseLiteral',
        attributes: {
        },
        nest: () {

        });
  }
}