
library application.block;

import 'dart:core';
import 'package:xml/xml.dart' as xml;
import 'dart:collection';
import 'statement.dart';

abstract class Block {

  Block() {

  }

  var parent;

  String toPython(int indentLevel);

  String toDeclarePython(int indentLevel) {
    return "";
  }

  String toBindPython(int indentLevel) {
    return "";
  }

  void iterateBlock(var func) {}


  void buildXML(xml.XmlBuilder builder) {}

  void element(xml.XmlBuilder builder, {attributes : null, nest : null}) {
    if (attributes == null) attributes = {};
    if (nest == null) nest = () {};

    builder.element(this.runtimeType.toString(),
      attributes: attributes,
      nest : nest
    );
  }

  void child(xml.XmlNode node, Function func, {String name : null}) {
    node.children.forEach((xml.XmlNode childNode) {
      if(childNode is xml.XmlElement) {
        if (name == null || childNode.name.toString() == name) {
          func(childNode);
        }
      }
    });
  }

  void namedChild(xml.XmlNode node, String name, Function func) {
    child(node, func, name: name);
  }

  void namedChildChildren(xml.XmlNode node, String name, Function func) {
    child(node, (xml.XmlElement e) {
      child(e, func);
    }, name: name);
  }
}




class BlockList extends ListMixin<Block> {

  List<Block> list = [];

  BlockList() {
  }

  void set length(int newLength) {list.length = newLength;}

  int get length => list.length;

  Block operator[](int index) => list[index];

  void operator[]=(int index, Block value) {list[index] = value;}

  void add(Block child) {list.add(child);}
}