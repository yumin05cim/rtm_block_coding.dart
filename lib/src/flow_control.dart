library application.flow_control;



import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';
import 'block_loader.dart';

class If extends Block {
  Condition condition;
  StatementList yes = new StatementList([]);
  StatementList no = new StatementList([]);

  If(this.condition, this.yes, {StatementList no: null}) {
    this.no = no;
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "if ${condition.toPython(0)}:\n";
    for (Statement s in yes) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    if (no != null) {
      sb += Statement.indent * indentLevel + "else : \n";
      for (Statement s in no) {
        sb += s.toPython(indentLevel + 1) + '\n';
      }
    }
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in yes) {
      s.iterateBlock(func);
    }
    for (var s in no) {
      s.iterateBlock(func);
    }
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('If',
        attributes: {
        },
        nest: () {
          builder.element('Condition',
            nest : () {
              condition.buildXML(builder);
            });

          builder.element('Yes',
              nest : () {
              yes.buildXML(builder);
              });

          builder.element('No',
              nest : () {
              no.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'If');
    }
    return false;
  }

  If.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Condition') {
          condition = BlockLoader.parseBlock(childNode.children[0]);
        } else if (childNode.name.toString() == 'Yes') {
          yes.loadFromXML(childNode.children[0]);
        } else if (childNode.name.toString() == 'No') {
          no.loadFromXML(childNode.children[0]);
        }
      }
    });
  }
}

class While extends Block {
  Condition condition;

  StatementList loop = new StatementList([]);

  While(this.condition, this.loop) {}


  String toPython(int indentLevel) {
    String sb = "";
    sb = "while ${condition.toPython(0)}:\n";
    for (Statement s in loop) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in loop) {
      s.iterateBlock(func);
    }
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('While',
        attributes: {
        },
        nest: () {
          builder.element('Condition',
              nest : () {
                condition.buildXML(builder);
              });

          builder.element('Loop',
              nest : () {
                loop.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'While');
    }
    return false;
  }

  While.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Condition') {
          condition = BlockLoader.parseBlock(childNode.children[0]);
        } else if (childNode.name.toString() == 'Loop') {
          loop.loadFromXML(childNode.children[0]);
        }
      }
    });
  }

}

class Break extends Block {

  Break() {}

  String toPython(int indentLevel) {
    return 'break';
  }
  void buildXML(xml.XmlBuilder builder) {
    builder.element('Break',
        attributes: {
        },
        nest: () {

        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'Break');
    }
    return false;
  }

  Break.XML(xml.XmlElement node) {

  }
}