
library application.condition;
import 'block.dart';


import 'package:xml/xml.dart' as xml;
import 'block_loader.dart';

abstract class Condition extends Block {

  Condition() {}

  /*
  String toPython(int indentLevel) {
    return _block.toPython(0);
  }
  */
}

class Comparison extends Condition {
  String operatorString = 'foo';
  Block _right;
  Block _left;


  get right => _right;
  get left => _left;

  Comparison(this._left, this._right, this.operatorString) {}

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} ${operatorString} ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest : () {
          builder.element('Left',
              nest : () {
                _left.buildXML(builder);
              });
          builder.element('Right',
              nest : () {
                _right.buildXML(builder);
              });

        });
  }

  void loadXML(xml.XmlElement node) {
    namedChildChildren(node, 'Right', (xml.XmlElement e) {
      _right = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'Left', (xml.XmlElement e) {
      _left = BlockLoader.parseBlock(e);
    });

  }

}

class Equals extends Comparison {

  Equals(Block left, Block right) : super(left, right, '=='){
  }

  Equals.XML(xml.XmlElement node) {
    super.loadXML(node);
  }
}


class NotEquals extends Comparison {

  NotEquals(Block left, Block right) : super(left, right, '!='){
  }

  NotEquals.XML(xml.XmlElement node) {
    super.loadXML(node);
  }
}


class SmallerThan extends Comparison {
  SmallerThan(Block left, Block right) : super(left, right, '<'){
  }

  SmallerThan.XML(xml.XmlElement node) {
    super.loadXML(node);
  }
}


class SmallerThanOrEquals extends Comparison {
  SmallerThanOrEquals(Block left, Block right) : super(left, right, '<='){
  }

  SmallerThanOrEquals.XML(xml.XmlElement node) {
    super.loadXML(node);
  }
}

class LargerThan extends Comparison {
  LargerThan(Block left, Block right) : super(left, right, '>'){
  }
  LargerThan.XML(xml.XmlElement node) {
    super.loadXML(node);
  }
}


class LargerThanOrEquals extends Comparison {
  LargerThanOrEquals(Block left, Block right) : super(left, right, '>'){
  }
  LargerThanOrEquals.XML(xml.XmlElement node) {
    super.loadXML(node);
  }
}

class TrueLiteral extends Condition {

  TrueLiteral() {}

  String toPython(int indentLevel) {
    return "True";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {

        });
  }

  TrueLiteral.XML(xml.XmlElement node) {
  }
}

class FalseLiteral extends Condition {

  FalseLiteral() {}

  String toPython(int indentLevel) {
    return "False";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {

        });
  }

  FalseLiteral.XML(xml.XmlElement node) {
  }
}

class Not extends Condition {

  Condition condition;

  Not(this.condition) {}

  String toPython(int indentLevel) {
    return "not ${condition.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          condition.buildXML(builder);
        });
  }

  Not.XML(xml.XmlElement node) {
    child(node, (xml.XmlElement e) {
      condition = BlockLoader.parseBlock(e);
    });
  }
}