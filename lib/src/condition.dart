
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

class Equals extends Condition {
  Block _a;
  Block _b;

  get a => _a;
  get b => _b;

  Equals(this._a, this._b) {
  }

  String toPython(int indentLevel) {
    return "${_a.toPython(0)} == ${_b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Equals',
        attributes: {
        },
        nest : () {
          builder.element('a',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('b',
              nest : () {
                b.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'Equals');
    }
    return false;
  }

  Equals.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _a = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'b') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _b = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}


class NotEquals extends Condition {
  Block _a;
  Block _b;

  get a => _a;
  get b => _b;

  NotEquals(this._a, this._b) {
  }

  String toPython(int indentLevel) {
    return "${_a.toPython(0)} != ${_b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('NotEquals',
        attributes: {
        },
        nest : () {
          builder.element('a',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('b',
              nest : () {
                b.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'NotEquals');
    }
    return false;
  }

  NotEquals.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _a = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'b') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _b = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}


class SmallerThan extends Condition {
  Block _left;
  Block _right;

  get left => _left;
  get right => _right;

  SmallerThan(this._left, this._right) {
  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} <  ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('SmallerThan',
        attributes: {
        },
        nest : () {
          builder.element('Left',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('Right',
              nest : () {
                b.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'SmallerThan');
    }
    return false;
  }

  SmallerThan.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Left') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _left = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'Right') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _right = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}


class SmallerThanOrEquals extends Condition {
  Block _left;
  Block _right;

  get left => _left;
  get right => _right;

  SmallerThanOrEquals(this._left, this._right) {
  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} <=  ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('SmallerThanOrEquals',
        attributes: {
        },
        nest : () {
          builder.element('Left',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('Right',
              nest : () {
                b.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'SmallerThanOrEquals');
    }
    return false;
  }

  SmallerThanOrEquals.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Left') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _left = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'Right') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _right = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}

class LargerThan extends Condition {
  Block _left;
  Block _right;

  get left => _left;
  get right => _right;

  LargerThan(this._left, this._right) {
  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} >  ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('LargerThan',
        attributes: {
        },
        nest : () {
          builder.element('Left',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('Right',
              nest : () {
                b.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'LargerThan');
    }
    return false;
  }

  LargerThan.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Left') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _left = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'Right') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _right = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}


class LargerThanOrEquals extends Condition {
  Block _left;
  Block _right;

  get left => _left;
  get right => _right;

  LargerThanOrEquals(this._left, this._right) {
  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} >=  ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('LargerThanOrEquals',
        attributes: {
        },
        nest : () {
          builder.element('Left',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('Right',
              nest : () {
                b.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'LargerThanOrEquals');
    }
    return false;
  }

  LargerThanOrEquals.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Left') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _left = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'Right') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              _right = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}

class TrueLiteral extends Condition {

  TrueLiteral() {}

  String toPython(int indentLevel) {
    return "True";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('TrueLiteral',
        attributes: {
        },
        nest: () {

        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'TrueLiteral');
    }
    return false;
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
    builder.element('FalseLiteral',
        attributes: {
        },
        nest: () {

        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'FalseLiteral');
    }
    return false;
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
    builder.element('Not',
        attributes: {
        },
        nest: () {
          condition.buildXML(builder);
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'Not');
    }
    return false;
  }

  Not.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        condition = BlockLoader.parseBlock(childNode);
      }
    });
  }
}