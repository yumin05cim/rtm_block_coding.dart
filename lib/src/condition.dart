
library application.condition;
import 'block.dart';


import 'package:xml/xml.dart' as xml;
import 'block_loader.dart';

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

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'Equals');
    }
    return false;
  }

  Equals.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          _a = BlockLoader.parseBlock(childNode.children[0]);
        } else if (childNode.name.toString() == 'b') {
          _b = BlockLoader.parseBlock(childNode.children[0]);
        }
      }
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

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'TrueLiteral');
    }
    return false;
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
    builder.element('FalseLiteral',
        attributes: {
        },
        nest: () {

        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'FalseLiteral');
    }
    return false;
  }

  FalseLiteral.XML(xml.XmlElement node) {

  }
}