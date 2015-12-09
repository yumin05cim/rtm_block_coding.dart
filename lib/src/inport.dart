library application.inport;



import 'dart:core';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';

import 'datatype.dart';

class ReadInPort extends Block {
  String name;
  DataType dataType;

  StatementList statements = [];

  ReadInPort(this.name, this.dataType) {
  }

  @override
  String toDeclarePython(int indentLevel) {
    String sb = "";
    sb = "self._d_${name} = " + dataType.constructorString() + '\n';
    sb += Statement.indent * indentLevel + 'self._${name}In = OpenRTM_aist.InPort("${name}", self._d_${name})';
    return sb;
  }

  @override
  String toBindPython(int indentLevel) {
    String sb = "";
    sb = 'self.addInPort("${name}", self._${name}In)';
    return sb;
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "if self._${name}In.isNew():\n";
    sb += Statement.indent * (indentLevel+1) + 'self._d_${name} = self._${name}In.read()\n';
    for (Statement s in statements) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    return sb;

  }

  @override
  void iterateBlock(var func) {
    for(var s in statements) {
      s.iterateBlock(func);
    }
  }
}

class InPortDataAccess extends Block {
  String name;
  DataType dataType;
  String accessSequence;

  InPortDataAccess(this.name, this.dataType, this.accessSequence) {
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = 'self._d_${name}.${accessSequence}';
    return sb;
  }
}