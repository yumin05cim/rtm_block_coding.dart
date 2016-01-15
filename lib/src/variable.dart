library application.variable;

/// 変数に関する基本クラス

import 'dart:core';
import 'package:xml/xml.dart' as xml;
import 'dart:collection';
import 'statement.dart';

import 'datatype.dart';
import 'block.dart';
import 'block_loader.dart';


/// 変数を定義するブロック
/// 変数名のみを格納する
/// もしC++にまで拡張するなら変数のタイプも持っておくべきだ
class Variable extends Block {
  String _name;

  get name => _name;

  set name(String n) => _name = n;

  Variable(this._name) {}

  toPython(int indentLevel) {
    return _name;
  }

  void buildXML(xml.XmlBuilder builder) {
    element(builder, attributes: {'name': _name,}, nest: () {});
  }

  Variable.XML(xml.XmlElement node) {
    _name = (node.getAttribute('name'));
  }
}


/// 変数の宣言をするブロック
/// 基本的にはonInitializeに追加することを前提としてる
class  DeclareVariable extends Block {
  String _name;
  DataType _dataType;

  get name => _name;
  set name(String n) => _name = n;

  get dataType => _dataType;
  set dataType(DataType dt) {
    if (DataType.isPrimitiveType(dt)) {
      _dataType = dt;
    } else {
      print('Error. DeclareValue can not set not-primitive data type: ' +
          dt.typename);
    }
  }

  DeclareVariable(this._name, this._dataType) {}


  @override
  String toDeclarePython(int indentLevel) {
    String sb = "";
    sb = "self._${name} = " + dataType.constructorString() + '\n';
    return sb;
  }

  @override
  String toBindPython(int indentLevel) {
    return '';
  }

  @override
  String toPython(int indentLevel) {
    return '';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }


  DeclareVariable.XML(xml.XmlElement node) {
    name = node.getAttribute('name');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
  }
}