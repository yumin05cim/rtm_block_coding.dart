library application.block;

/// ブロックコーディング用の基本クラス Block を定義s

import 'dart:core';
import 'package:xml/xml.dart' as xml;
import 'dart:collection';
import 'statement.dart';
import 'block_loader.dart';

/// ブロックコーディングの基礎クラス．
/// ブロックに共通のコードをここで定義
abstract class Block {

  /// ブロックはツリー状構造なので，上位のブロックもしくはステートメントを指す変数
  var parent;

  /// 基本コンストラクタ．何もしない
  Block() {}

  /// Pythonのコードを返す．indentLevelはPythonコードのインデントを知るための変数
  /// ifなどのブロックでは改行が必要になるので，そのブロック自身のインデントが必要になる
  String toPython(int indentLevel);

  /// RTM用に追加した関数．RTコンポーネントのコンストラクタで，
  /// データポートの変数を宣言するコードを返す
  String toDeclarePython(int indentLevel) {
    return "";
  }

  /// RTM用に追加した関数．RTコンポーネントのonInitializeで，
  /// データポートをaddPortするコードを返す
  String toBindPython(int indentLevel) {
    return "";
  }

  /// ブロック内部のブロックに対してfunc関数を適用するイテレータ
  /// funcはfunc(Block _innerBlock)で呼ばれる
  void iterateBlock(var func) {}

  /// XMLファイルを生成するために使う関数．各クラスで定義すること
  void buildXML(xml.XmlBuilder builder) {}

  /// XMLファイルを生成するために使うユーティリティ関数．
  /// buildXMLの中ではほぼこの関数が呼ばれる．
  void element(xml.XmlBuilder builder, {attributes : null, nest : null}) {
    if (attributes == null) attributes = {};
    if (nest == null) nest = () {};

    builder.element(this.runtimeType.toString(),
      attributes: attributes,
      nest : nest
    );
  }

  /// node要素の子要素に対してfuncを適用するイテレータ．
  /// 引数nameで子要素の名前タグを振り分けることができる
  void child(xml.XmlNode node, Function func, {String name : null, Type type : null}) {
    node.children.forEach((xml.XmlNode childNode) {
      if(childNode is xml.XmlElement) {
        if (name == null || childNode.name.toString() == name) {
          if (type == null || BlockLoader.isClassXmlNode(childNode, type)) {
            func(childNode);
          }
        }
      }
    });
  }

  /// 名前タグで子要素を振り分ける場合のユーティリティ．
  /// child関数を読んでいるだけだが，引数の順序が変わるので便利
  void namedChild(xml.XmlNode node, String name, Function func) {
    child(node, func, name: name);
  }

  /// 名前タグで子要素を振り分け，かつさらにその子要素に対してfuncを適用するイテレータ
  void namedChildChildren(xml.XmlNode node, String name, Function func) {
    child(node, (xml.XmlElement e) {
      child(e, func);
    }, name: name);
  }

  /// タイプで子要素を振り分ける場合のユーティリティ．
  /// child関数を読んでいるだけだが，引数の順序が変わるので便利
  void typedChild(xml.XmlNode node, Type type, Function func) {
    child(node, func, type: type);
  }
}




class BlockList extends ListMixin<Block> {

  List<Block> list = [];

  BlockList() {
  }

  void set length(int newLength) {list.length = newLength;}

  int get length => list.length;

  Block operator[](int index) => list[index];

  void operator[]=(int index, Block value) {list[index] = value;}

  void add(Block child) {list.add(child);}
}