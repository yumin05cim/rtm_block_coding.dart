

library application.io;


import 'package:xml/xml.dart' as xml;
import 'block.dart';
import 'block_loader.dart';

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

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'Print');
    }
    return false;
  }

  Print.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if(childNode is xml.XmlElement) {
        _block = BlockLoader.parseBlock(childNode);
      }
    });
  }
}