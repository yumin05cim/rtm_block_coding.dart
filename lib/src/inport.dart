library application.inport;



import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';

import 'datatype.dart';

class AddInPort extends Block {
  String name;
  DataType dataType;

  AddInPort(this.name, this.dataType) {

  }

  @override
  String toDeclarePython(int indentLevel) {
    String sb = "";
    sb = "self._d_${name} = " + dataType.constructorString() + '\n';
    sb += Statement.indent * indentLevel + 'self._${name}In = OpenRTM_aist.InPort("${name}", self._d_${name})' + '\n';
    return sb;
  }

  @override
  String toBindPython(int indentLevel) {
    String sb = "";
    sb = 'self.addInPort("${name}", self._${name}In)' + '\n';
    return sb;
  }

  String toPython(int indentLevel) {
    return '';
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('AddInPort',
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'AddInPort');
    }
    return false;
  }

  AddInPort.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    node.children.forEach((xml.XmlNode childNode) {
      if(childNode is xml.XmlElement) {
        dataType = new DataType.XML(childNode);
      }
    });
  }
}



class ReadInPort extends Block {
  String name;
  DataType dataType;

  StatementList statements = new StatementList([]);

  ReadInPort(this.name, this.dataType) {
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "if self._${name}In.isNew():\n";
    sb += Statement.indent * (indentLevel+1) + 'self._d_${name} = self._${name}In.read()\n';
    for (Statement s in statements) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    return sb;

  }

  @override
  void iterateBlock(var func) {
    for(var s in statements) {
      s.iterateBlock(func);
    }
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('ReadInPort',
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'ReadInPort');
    }
    return false;
  }

  ReadInPort.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    node.children.forEach((xml.XmlNode childNode) {
      if(childNode is xml.XmlElement) {
        dataType = new DataType.XML(childNode);
      }
    });
  }
}

class InPortDataAccess extends Block {
  String name;
  DataType dataType;
  String accessSequence;

  InPortDataAccess(this.name, this.dataType, this.accessSequence) {
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = 'self._d_${name}.${accessSequence}';
    return sb;
  }


  void buildXML(xml.XmlBuilder builder) {
    builder.element('InPortDataAccess',
        attributes: {
          'name' : name,
          'accessSequence' : accessSequence,
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'InPortDataAccess');
    }
    return false;
  }

  InPortDataAccess.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    accessSequence = node.getAttribute('accessSequence');
    node.children.forEach((xml.XmlNode childNode) {
      if(childNode is xml.XmlElement) {
        dataType = new DataType.XML(childNode);
      }
    });
  }
}