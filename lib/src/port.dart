library application.addport;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'datatype.dart';
import 'block_loader.dart';

abstract class AddPort extends Block {

  String name;
  DataType dataType;

  AddPort(this.name, this.dataType) {}

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  AddPort.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
  }

}
/*

abstract class AccessPort extends Block {

  String name;
  DataType dataType;
  String accessSequence;
  Block right;

  AccessPort(this.name, this.dataType, this.accessSequence){}

  AccessPort.XML(xml.XmlElement node){

    name = node.getAttribute('name');
    accessSequence = node.getAttribute('accessSequence');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
    namedChildChildren(node, 'Right', (xml.XmlElement e) {
      right = BlockLoader.parseBlock(e);
    });

  }

}
*/

