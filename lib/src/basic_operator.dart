library application.basic_operator;


import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'block_loader.dart';

class Variable extends Block {

  String _name;

  get name => _name;

  set name(String n) => _name = n;

  Variable(this._name) {}

  toPython(int indentLevel) {
    return _name;
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Variable',
        attributes: {
          'name' : _name,
        },
        nest : () {

        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'Variable');
    }
    return false;
  }

  Variable.XML(xml.XmlElement node) {
    _name = (node.getAttribute('name'));
  }
}

class SetValue extends Block {
  Variable _left;
  Block _right;

  get left => _left;
  get right => _right;

  set right(var r) => _right = r;

  SetValue(this._left, this._right) {

  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} = ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('SetValue',
        attributes: {},
        nest : () {
          builder.element('Left',
              nest: () {
                _left.buildXML(builder);
              });
          builder.element('Right',
              nest: () {
                _right.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    print('SetValue isClassXmlNode?:' + node.toString());
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'SetValue');
    }
    return false;
  }

  SetValue.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Left') {
          _left = BlockLoader.parseBlock(childNode.children[0]);
        } else if (childNode.name.toString() == 'Right') {
          _right = BlockLoader.parseBlock(childNode.children[0]);
        }
      }
    });
  }
}

class Add extends Block {

  Block a;
  Block b;

  Add(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} + ${b.toPython(0)}";
  }


  void buildXML(xml.XmlBuilder builder) {
    builder.element('Add',
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
      return (node.name.toString() == 'Add');
    }
    return false;
  }

  Add.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          a = BlockLoader.parseBlock(childNode.children[0]);
        } else if (childNode.name.toString() == 'b') {
          b = BlockLoader.parseBlock(childNode.children[0]);
        }
      }
    });
  }
}

class Subtract extends Block {
  Block a;
  Block b;

  Subtract(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} - ${b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Subtract',
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
      return (node.name.toString() == 'Subtract');
    }
    return false;
  }

  Subtract.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          a = BlockLoader.parseBlock(childNode.children[0]);
        } else if (childNode.name.toString() == 'b') {
          b = BlockLoader.parseBlock(childNode.children[0]);
        }
      }
    });
  }

}

class Multiply extends Block {
  Block a;
  Block b;

  Multiply(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} * ${b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Multiply',
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
      return (node.name.toString() == 'Mulatiply');
    }
    return false;
  }

  Multiply.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          a = BlockLoader.parseBlock(childNode.children[0]);
        } else if (childNode.name.toString() == 'b') {
          b = BlockLoader.parseBlock(childNode.children[0]);
        }
      }
    });
  }
}