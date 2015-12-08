

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
}