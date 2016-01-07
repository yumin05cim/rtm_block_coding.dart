

library application.base;

import 'dart:core';
import 'statement.dart';
import 'block.dart';
import 'datatype.dart';
import 'inport.dart';
import 'outport.dart';

class Application {

  StatementList statements;

  Application() {
    statements = new StatementList([]);
  }


  String toPython(int indentLevel) {
    String sb = "";
    for (Statement s in statements) {
      sb = sb + s.toPython(indentLevel) +  '\n';
    }

    return sb;
  }


  String toDeclarePython(int indentLevel) {
    String sb = "";
    for (Statement s in statements) {
      String temp = s.toDeclarePython(indentLevel);
      if (temp.length > 0) {
        sb += temp + '\n';
      }
    }
    return sb;
  }

  String toBindPython(int indentLevel) {
    String sb = "";
    for (Statement s in statements) {
      String temp = s.toBindPython(indentLevel);
      if (temp.length > 0) {
        sb += temp + '\n';
      }
    }
    return sb;
  }

  void iterateBlock(var func) {
    for(Statement s in statements) {
      s.iterateBlock(func);
    }
  }

  Map<String, DataType> getInPortMap() {
    Map<String, DataType> portMap = {};
    iterateBlock(
        (Block b) {
          if (b is AddInPort) {
            portMap[b.name] = b.dataType;
          }
        }
    );

    return portMap;
  }


  Map<String, DataType> getOutPortMap() {
    Map<String, DataType> portMap = {};
    iterateBlock(
        (Block b) {
          print (b);
      if (b is AddOutPort) {
        portMap[b.name] = b.dataType;
      }
    }
    );

    return portMap;
  }
}