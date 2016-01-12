
library application.outport;


import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'statement.dart';
import 'datatype.dart';



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
}

class OutPortData extends Block {
  String name;
  Block right;
  DataType dataType;
  String accessSequence;

  OutPortData(this.name, this.dataType, this.accessSequence, this.right) {

  }

  String toPython(int indentLevel) {
    return "self._d_${name}.${accessSequence} = ${right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('OutPortData',
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
}

class OutPortWrite extends Block {
  String name;
  DataType dataType;

  OutPortWrite(this.name, this.dataType) {
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = 'self._${name}Out.write()';
    return sb;
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('OutPortWrite',
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

}