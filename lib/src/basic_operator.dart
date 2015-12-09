library application.basic_operator;


import 'dart:core';
import 'block.dart';


class Variable extends Block {

  String _name;

  get name => _name;

  set name(String n) => _name = n;

  Variable(this._name) {}

  toPython(int indentLevel) {
    return _name;
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
}

class Add extends Block {

  Block _a;
  Block _b;

  Add(this._a, this._b) : super() {}

  String toPython(int indentLevel) {
    return "${_a.toPython(0)} + ${_b.toPython(0)}";
  }
}

class Subtract extends Block {
  Block _a;
  Block _b;

  Subtract(this._a, this._b) : super() {}

  String toPython(int indentLevel) {
    return "${_a.toPython(0)} - ${_b.toPython(0)}";
  }

}