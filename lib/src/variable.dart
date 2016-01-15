library application.variable;

/// 変数に関する基本クラス

import 'dart:core';
import 'package:xml/xml.dart' as xml;
import 'dart:collection';
import 'statement.dart';
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