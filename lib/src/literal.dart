
library application.literal;

import 'dart:core';
import 'block.dart';

class Integer extends Block {

  int _a;

  get value => _a;

  set value(int i) => _a = i;

  Integer(this._a) {}

  String toPython(int indentLevel) {
    return _a.toString();
  }
}

class StringLiteral extends Block {

  String _a;

  get value => _a;

  set value(String s) => _a = s;

  StringLiteral(this._a) {}

  String toPython(int indentLevel) {
    return "'${_a.toString()}'";
  }
}