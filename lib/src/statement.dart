

library application.statement;

import 'dart:core';
import 'dart:collection';
import 'block.dart';

class Statement {

  static String _indent = "  ";
  Block _block;

  static String get indent { return _indent; }

  get block => _block;

  Statement(this._block) {
  }

  String toPython(indentLevel) {
    return _indent * indentLevel + _block.toPython(indentLevel);
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

  void add(Statement child) {list.add(child);}
}