library application.addport;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'datatype.dart';

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

