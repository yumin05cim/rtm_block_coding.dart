

library application.base;

import 'dart:core';
import 'statement.dart';


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
}