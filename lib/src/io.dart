

library application.io;


import 'block.dart';


class Print extends Block {

  Block _block;
  Print(this._block) {}

  String toPython(int indentLevel) {
    return "print ${_block.toPython(0)}";
  }
}