library application.basic_operator;


import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'block_loader.dart';

class Variable extends Block {

  String _name;

  get name => _name;

  set name(String n) => _name = n;

  Variable(this._name) {}

  toPython(int indentLevel) {
    return _name;
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Variable',
        attributes: {
          'name' : _name,
        },
        nest : () {

        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    print('Variable isClassXmlNode?:' + node.toString());
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'Variable');
    }
    return false;
  }

  Variable.XML(xml.XmlElement node) {
    print('Variable::' + node.toString());
    _name = (node.getAttribute('name'));
  }
}

class SetVariable extends Block {
  Variable _left;
  Block _right;

  get left => _left;
  get right => _right;

  set right(var r) => _right = r;

  SetVariable(this._left, this._right) {

  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} = ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('SetVariable',
        attributes: {},
        nest : () {
          builder.element('Left',
              nest: () {
                _left.buildXML(builder);
              });
          builder.element('Right',
              nest: () {
                _right.buildXML(builder);
              });
        });
  }

  static bool isClassXmlNode(xml.XmlNode node) {
    if(node is xml.XmlElement) {
      return (node.name.toString() == 'SetVariable');
    }
    return false;
  }

  SetVariable.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Left') {
          print('Left:' + childNode.toString());
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

class Add extends Block {

  Block a;
  Block b;

  Add(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} + ${b.toPython(0)}";
  }


  void buildXML(xml.XmlBuilder builder) {
    builder.element('Add',
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
      return (node.name.toString() == 'Add');
    }
    return false;
  }

  Add.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              a = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'b') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              b = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}

class Subtract extends Block {
  Block a;
  Block b;

  Subtract(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} - ${b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Subtract',
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
      return (node.name.toString() == 'Subtract');
    }
    return false;
  }

  Subtract.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              a = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'b') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              b = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }

}

class Multiply extends Block {
  Block a;
  Block b;

  Multiply(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} * ${b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Multiply',
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
      return (node.name.toString() == 'Mulatiply');
    }
    return false;
  }

  Multiply.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'a') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              a = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'b') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              b = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}


class Div extends Block {
  Block a;
  Block b;

  Div(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} / ${b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    builder.element('Div',
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
      return (node.name.toString() == 'Div');
    }
    return false;
  }

  Div.XML(xml.XmlElement node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        if (childNode.name.toString() == 'Left') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              a = BlockLoader.parseBlock(gChildNode);
            }
          });
        } else if (childNode.name.toString() == 'Right') {
          childNode.children.forEach((xml.XmlNode gChildNode) {
            if(gChildNode is xml.XmlElement) {
              b = BlockLoader.parseBlock(gChildNode);
            }
          });
        }
      }
    });
  }
}