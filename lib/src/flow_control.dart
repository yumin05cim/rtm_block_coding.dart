library application.flow_control;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';
import 'block_loader.dart';

class If extends Block {
  Condition condition;
  StatementList statements = new StatementList([]);

  If(this.condition, this.statements) {
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "if ${condition.toPython(0)}:\n";
    for (Statement s in statements) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in statements) {
      s.iterateBlock(func);
    }
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          builder.element('Condition',
            nest : () {
              condition.buildXML(builder);
            });
          statements.buildXML(builder);
        });
  }


  If.XML(xml.XmlElement node) {
    namedChildChildren(node, 'Condition', (xml.XmlElement e) {
      condition = BlockLoader.parseBlock(e);
    });
    typedChild(node, StatementList, (xml.XmlElement e) {
      statements.loadFromXML(e);
    });
  }
}

class Else extends Block {
  StatementList statements = new StatementList([]);

  Else(this.statements) {
  }

  @override
  void iterateBlock(var func) {
    for (var s in statements) {
      s.iterateBlock(func);
    }
  }

  String toPython(int indentLevel) {
    String sb = "";
    if (statements != null) {
      sb += Statement.indent * indentLevel + "else : \n";
      for (Statement s in statements) {
        sb += s.toPython(indentLevel + 1) + '\n';
      }
    }
    return sb;
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          statements.buildXML(builder);
        });
  }

  Else.XML(xml.XmlElement node) {
    typedChild(node, StatementList, (xml.XmlElement e) {
      statements.loadFromXML(e);
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
    super.element(builder,
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

  While.XML(xml.XmlElement node) {
    namedChildChildren(node, 'Condition', (xml.XmlElement e) {
      condition = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'Loop', (xml.XmlElement e) {
      loop.loadFromXML(e);
    });
  }
}

class Break extends Block {

  Break() {}

  String toPython(int indentLevel) {
    return 'break';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {

        });
  }

  Break.XML(xml.XmlElement node) {

  }
}

class Continue extends Block {

  Continue() {}

  String toPython(int indentLevel) {
    return 'continue';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {

        });
  }

  Continue.XML(xml.XmlElement node) {

  }
}

class Pass extends Block {

  Pass() {}

  String toPython(int indentLevel) {
    return 'pass';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
        });
  }

  Pass.XML(xml.XmlElement node) {

  }
}