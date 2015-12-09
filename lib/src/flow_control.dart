library application.flow_control;



import 'dart:core';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';

class If extends Block {
  Condition _condition;
  StatementList _yes;
  StatementList _no;

  If(this._condition, this._yes, {StatementList no: null}) {
    this._no = no;
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "if ${_condition.toPython(0)}:\n";
    for (Statement s in _yes) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    if (_no != null) {
      sb += Statement.indent * indentLevel + "else : \n";
      for (Statement s in _no) {
        sb += s.toPython(indentLevel + 1) + '\n';
      }
    }
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in _yes) {
      s.iterateBlock(func);
    }
    for (var s in _no) {
      s.iterateBlock(func);
    }
  }
}

class While extends Block {
  Condition _condition;

  StatementList _loop;

  While(this._condition, this._loop) {}


  String toPython(int indentLevel) {
    String sb = "";
    sb = "while ${_condition.toPython(0)}:\n";
    for (Statement s in _loop) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in _loop) {
      s.iterateBlock(func);
    }
  }
}

class Break extends Block {

  Break() {}

  String toPython(int indentLevel) {
    return 'break';
  }
}