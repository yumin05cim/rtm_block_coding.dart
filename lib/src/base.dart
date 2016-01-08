

library application.base;

import 'dart:core';
import 'statement.dart';
import 'block.dart';
import 'datatype.dart';
import 'inport.dart';
import 'outport.dart';
import 'dart:mirrors';

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


  find(Type typename, {String name: null}) {
    var ret = [];

    iterateBlock(
        (Block b) {
          if (b.runtimeType == typename) {
            if(name == null) {
              ret.add(b);
            }
            else if(b.name == name) {
              ret.add(b);
            }
          }
    });

    if(name == null && ret.length == 0) {
      return null;
    }
    return ret;
  }
}