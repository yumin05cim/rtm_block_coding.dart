
library application.outport;


import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'statement.dart';
import 'datatype.dart';
import 'block_loader.dart';


class AddOutPort extends Block {
  String name;
  DataType dataType;

  AddOutPort(this.name, this.dataType) {

  }

  @override
  String toDeclarePython(int indentLevel) {
    String sb = "";
    sb = "self._d_${name} = " + dataType.constructorString() + '\n';
    sb += Statement.indent * indentLevel +
        'self._${name}Out = OpenRTM_aist.OutPort("${name}", self._d_${name})';
    return sb;
  }

  @override
  String toBindPython(int indentLevel) {
    String sb = "";
    sb = 'self.addOutPort("${name}", self._${name}Out)';
    return sb;
  }

  String toPython(int indentLevel) {
    return '';
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('AddOutPort',
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'AddOutPort');
    }
    return false;
  }

  AddOutPort.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    node.children.forEach((xml.XmlNode childNode) {
      if(childNode is xml.XmlElement) {
        dataType = new DataType.XML(childNode);
      }
    });
  }
}

class AccessOutPort extends Block {
  String name;
  Block right;
  DataType dataType;
  String accessSequence;

  AccessOutPort(this.name, this.dataType, this.accessSequence, this.right) {

  }

  String toPython(int indentLevel) {
    return "self._d_${name}.${accessSequence} = ${right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('AccessOutPort',
        attributes: {
          'name' : name,
          'accessSequence' :accessSequence,
        },
        nest: () {
          dataType.buildXML(builder);
          builder.element('Right',
            nest: () {
              right.buildXML(builder);
            }
          );
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'AccessOutPort');
    }
    return false;
  }

  AccessOutPort.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    accessSequence = node.getAttribute('accessSequence');
    node.children.forEach((xml.XmlNode childNode) {
      if (DataType.isClassXmlNode(childNode)) {
        dataType = new DataType.XML(childNode);
      } else if((childNode as xml.XmlElement).name.toString() == 'Right') {
        childNode.children.forEach((xml.XmlNode gChildNode) {
          if(gChildNode is xml.XmlElement) {
            right = BlockLoader.parseBlock(gChildNode);
          }
        });
      }
    });
  }
}

class WriteOutPort extends Block {
  String name;
  DataType dataType;

  WriteOutPort(this.name, this.dataType) {
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = 'self._${name}Out.write()';
    return sb;
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('WriteOutPort',
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'WriteOutPort');
    }
    return false;
  }

  WriteOutPort.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    node.children.forEach((xml.XmlNode childNode) {
      if(childNode is xml.XmlElement) {
        dataType = new DataType.XML(childNode);
      }
    });
  }
}