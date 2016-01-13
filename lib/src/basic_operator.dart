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
    element(builder,
        attributes: {
          'name' : _name,
        },
        nest : () {

        });
  }

  Variable.XML(xml.XmlElement node) {
    _name = (node.getAttribute('name'));
  }
}

class SetVariable extends Block {
  Variable _left;
  Block _right;

  get left => _left;
  get right => _right;

  set right(var r) => _right = r;

  SetVariable(this._left, this._right) {

  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} = ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
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

  SetVariable.XML(xml.XmlElement node) {
    namedChildChildren(node, 'Left', (xml.XmlElement e) {
      _left = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'Right', (xml.XmlElement e) {
      _right = BlockLoader.parseBlock(e);
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
    super.element(builder,
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


  Add.XML(xml.XmlElement node) {
    namedChildChildren(node, 'a', (xml.XmlElement e) {
      a = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'b', (xml.XmlElement e) {
      b = BlockLoader.parseBlock(e);
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
    super.element(builder,
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

  Subtract.XML(xml.XmlElement node) {
    namedChildChildren(node, 'a', (xml.XmlElement e) {
      a = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'b', (xml.XmlElement e) {
      b = BlockLoader.parseBlock(e);
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
    super.element(builder,
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

  Multiply.XML(xml.XmlElement node) {
    namedChildChildren(node, 'a', (xml.XmlElement e) {
      a = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'b', (xml.XmlElement e) {
      b = BlockLoader.parseBlock(e);
    });
  }
}


class Div extends Block {
  Block a;
  Block b;

  Div(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} / ${b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest : () {
          builder.element('Left',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('Right',
              nest : () {
                b.buildXML(builder);
              });
        });
  }

  Div.XML(xml.XmlElement node) {
    namedChildChildren(node, 'Leftt', (xml.XmlElement e) {
      a = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'Right', (xml.XmlElement e) {
      b = BlockLoader.parseBlock(e);
    });
  }
}