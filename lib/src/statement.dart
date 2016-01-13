

library application.statement;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'dart:collection';
import 'block.dart';
import 'block_loader.dart';

class Statement {

  static String _indent = "  ";
  Block _block;

  static String get indent { return _indent; }

  get block => _block;

  var parent;

  Statement(this._block) {
    this._block.parent = this;
  }


  String toPython(indentLevel) {
    return _indent * indentLevel + _block.toPython(indentLevel);
  }

  String toDeclarePython(indentLevel) {
    String temp = _block.toDeclarePython(indentLevel);
    if (temp.length > 0) {
      return _indent * indentLevel + temp;
    }
    return "";
  }

  String toBindPython(indentLevel) {
    String temp = _block.toBindPython(indentLevel);
    if (temp.length > 0) {
      return _indent * indentLevel + temp;
    }
    return "";
  }

  void iterateBlock(var func) {
    func(_block);
    _block.iterateBlock(func);
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Statement',
        attributes: {
        },
        nest : () {
          block.buildXML(builder);

        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if (node is xml.XmlElement) {
      return (node.name.toString() == 'Statement');
    }
    return false;
  }

  Statement.XML(xml.XmlNode node) {
    node.children.forEach((xml.XmlNode childNode) {
      var b = BlockLoader.parseBlock(childNode);
      if (b is Block) {
        this._block = b;
      }
    });
  }
}

class StatementList extends ListMixin<Statement> {

  List<Statement> list = [];

  StatementList(List<Statement> l) {
    list.addAll(l);
  }

  void set length(int newLength) {list.length = newLength;}

  int get length => list.length;

  Statement operator[](int index) => list[index];

  void operator[]=(int index, Statement value) {list[index] = value;}

  void add(Statement child) {
    child.parent = this;
    list.add(child);
  }

  @override
  bool remove(Statement child) {
    var b = super.remove(child);
    child.parent = null;
    return b;
  }

  @override
  void insert(int index, Statement child) {
    super.insert(index, child);
    child.parent = this;
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Statements',
        attributes: {
        },
        nest : () {
          list.forEach((Statement s) {
            s.buildXML(builder);
          });
        });
  }

  bool isStatementListNode(xml.XmlNode node) {
    if (node is xml.XmlElement) {
      return (node.name.toString() == 'Statements');
    }
    return false;
  }


  void loadFromXML(xml.XmlNode node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (Statement.isClassXmlNode(childNode)) {
        this.add(new Statement.XML(childNode));
      }
    });
  }


}