

library application.io;


import 'package:xml/xml.dart' as xml;
import 'block.dart';


class Print extends Block {

  Block _block;
  Print(this._block) {}

  String toPython(int indentLevel) {
    return "print ${_block.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Print',
        attributes: {
        },
        nest: () {
          _block.buildXML(builder);
        });
  }
}