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

class BasicOperator extends Block {
  Block _a;
  Block _b;

  get a => _a;
  get b => _b;

  String _operatorString = 'foo';

  BasicOperator(this._a, this._b, this._operatorString) {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} ${_operatorString} ${b.toPython(0)}";
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


  void loadXML(xml.XmlElement node) {
    namedChildChildren(node, 'a', (xml.XmlElement e) {
      _a = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'b', (xml.XmlElement e) {
      _b = BlockLoader.parseBlock(e);
    });
  }
}

class Add extends BasicOperator {

  Add(Block a_, Block b_) : super(a_, b_, '+') {}

  Add.XML(xml.XmlElement node) : super(null, null, '+') {
    loadXML(node);
  }
}

class Subtract extends BasicOperator {

  Subtract(Block a_, Block b_) : super(a_, b_, '-') {}

  Subtract.XML(xml.XmlElement node) : super(null, null, '-') {
    loadXML(node);
  }

}

class Multiply extends BasicOperator {
  Subtract(Block a_, Block b_) : super(a_, b_, '*') {}

  Subtract.XML(xml.XmlElement node) : super(null, null, '*') {
    loadXML(node);
  }
}


class Div extends BasicOperator {
  Div(Block a_, Block b_) : super(a_, b_, '/') {}

  Div.XML(xml.XmlElement node) : super(null, null, '/') {
    loadXML(node);
  }
}