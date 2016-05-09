library block_loader;


import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'dart:mirrors';
import 'block.dart';
import 'literal.dart';
import 'basic_operator.dart';
import 'condition.dart';
import 'datatype.dart';
import 'flow_control.dart';
import 'inport.dart';
import 'io.dart';
import 'outport.dart';
import 'variable.dart';

/// ブロックをXMLから生成するためのクラス
/// Blockクラスは複数の子クラスを持ち，それぞれが別個にXMLを生成しているため
/// いろいろなフォーマットになっている
/// 一方で，StatementなどはXMLの生成を子要素ブロックのbuildXMLメソッドに任せてしまっているため，
/// 自分の子要素がどのクラスのBlockだったのか忘れてしまう．
/// そこで，ノードのタグ名から対応するBlockの子クラスを適切に判断し，
/// ダイナミックにコンストラクタを呼ぶユーティリティとしてこのクラスを使う
class BlockLoader {

  /// ブロックの子クラスのリスト
  static List<Type> blockTypes = [
    IntegerLiteral, StringLiteral, RealLiteral,
    SetVariable, ReferVariable, Assign, Add, Subtract, Multiply, Divide,
    Equals, SmallerThan, SmallerThanOrEquals, LargerThan, LargerThanOrEquals, Not, TrueLiteral, FalseLiteral,
    DataType,
    If, While, Break, Pass, Continue, 
    Print,
    AccessInPort, AddInPort, ReadInPort,
    AccessOutPort, AddOutPort, WriteOutPort,
  ];

  /// ブロックがtypeで定義されるクラスと対応しているか判断するメソッド
  static bool isClassXmlNode(xml.XmlElement node, Type type) {
    return (node.name.toString() == type.toString());
  }

  /// XMLのノード (node) からBlockクラスの子クラスを適切に選択して生成するメソッド
  static Block parseBlock(xml.XmlElement node) {
    var elem = null;
    blockTypes.forEach((Type T) {
      if(isClassXmlNode(node, T)) {
        elem = reflectClass(T).newInstance(new Symbol('XML'), [node]).reflectee;
      }
    });

    return elem;
  }

}
