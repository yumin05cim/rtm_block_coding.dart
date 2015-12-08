
library application.condition;
import 'block.dart';

abstract class Condition extends Block {

  Condition() {}

  /*
  String toPython(int indentLevel) {
    return _block.toPython(0);
  }
  */
}

class Equals extends Condition {
  Block _a;
  Block _b;

  Equals(this._a, this._b) {
  }

  String toPython(int indentLevel) {
    return "${_a.toPython(0)} == ${_b.toPython(0)}";
  }
}

class TrueLiteral extends Condition {

  TrueLiteral() {}

  String toPython(int indentLevel) {
    return "True";
  }
}

class FalseLiteral extends Condition {

  FalseLiteral() {}

  String toPython(int indentLevel) {
    return "False";
  }
}