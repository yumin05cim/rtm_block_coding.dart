library application.inport;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'statement.dart';
import 'datatype.dart';
import 'block_loader.dart';
import 'port.dart';

class AddInPort extends AddPort {

  AddInPort(String inName_, DataType inDataType_) : super(inName_, inDataType_) {
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

  AddInPort.XML(xml.XmlElement node) : super.XML(node){
  }
}


class AccessInPort extends Block {
  String name;
  DataType dataType;
  String accessSequence;

  AccessInPort(this.name, this.dataType, this.accessSequence) {
  }
/*  AccessInPort(String inName_, DataType dataType_, String accessSequence_) : super(inName_, dataType_, accessSequence_) {
  }*/

  String toPython(int indentLevel) {
    if (accessSequence.trim().length == 0) {
      return 'self._d_${name}';
    }
    return 'self._d_${name}.${accessSequence}';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'name' : name,
          'accessSequence' : accessSequence,
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  AccessInPort.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    accessSequence = node.getAttribute('accessSequence');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
  }
}

class InPortBuffer extends Block {
  String name;
  DataType dataType;
  String accessSequence;

  InPortBuffer(this.name, this.dataType, this.accessSequence) {
  }

  String toPython(int indentLevel) {
    if (accessSequence.trim().length == 0) {
      return 'self._d_${name}';
    }
    return 'self._d_${name}.${accessSequence}';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'name' : name,
          'accessSequence' : accessSequence,
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  InPortBuffer.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    accessSequence = node.getAttribute('accessSequence');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
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
    super.element(builder,
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
          statements.buildXML(builder);
        });
  }

  ReadInPort.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    typedChild(node, DataType, (xml.XmlElement e) {
        dataType = new DataType.XML(e);
    });
    typedChild(node, StatementList, (xml.XmlElement e) {
      statements.loadFromXML(e);
    });
  }
}