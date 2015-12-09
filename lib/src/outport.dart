
library application.outport;


import 'dart:core';
import 'block.dart';
import 'statement.dart';
import 'datatype.dart';

class OutPortData extends Block {
  String name;
  Block right;
  DataType dataType;
  String accessSequence;

  OutPortData(this.name, this.dataType, this.accessSequence, this.right) {

  }

  String toPython(int indentLevel) {
    return "self._d_${name}.${accessSequence} = ${right.toPython(0)}";
  }
}

class OutPortWrite extends Block {
  String name;
  DataType dataType;

  OutPortWrite(this.name, this.dataType) {
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = 'self._${name}Out.write()';
    return sb;
  }

  @override
  String toDeclarePython(int indentLevel) {
    String sb = "";
    sb = "self._d_${name} = " + dataType.constructorString() + '\n';
    sb += Statement.indent * indentLevel + 'self._${name}Out = OpenRTM_aist.OutPort("${name}", self._d_${name})';
    return sb;
  }

  @override
  String toBindPython(int indentLevel) {
    String sb = "";
    sb = 'self.addOutPort("${name}", self._${name}Out)';
    return sb;
  }
}