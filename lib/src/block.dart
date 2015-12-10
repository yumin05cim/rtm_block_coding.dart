
library application.block;

import 'dart:core';
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