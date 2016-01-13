
library application.statement;

/// ステートメント (プログラムにおける文）を定義する


import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'dart:collection';
import 'block.dart';
import 'block_loader.dart';

/// ステートメント (プログラムにおける文）
class Statement {

  /// Pythonのコードにおけるインデントレベル１つ分の空白を定義
  static String _indent = "  ";

  /// ステートメントは必ず一つのブロックを持つ
  Block _block;

  /// インデントのゲッター．
  /// この値がダイナミックに変更されると厄介なので
  static String get indent { return _indent; }

  /// ブロックのゲッター
  get block => _block;

  /// ステートメントの上位の要素を指すポインタ
  /// Ifブロックなどはステートメントを複数内部に持つ構造になっている．
  var parent;

  /// コンストラクタ
  /// 引数にはブロックを与える．引数がnullでなければ，引数のブロックの親要素を
  /// ステートメント自身に設定する
  Statement(this._block) {
    if (this._block != null) {
      this._block.parent = this;
    }
  }

  /// Pythonのコードを生成
  String toPython(indentLevel) {
    return _indent * indentLevel + _block.toPython(indentLevel);
  }


  /// RTM用に追加．RTCのコンストラクタで呼ばれるデータポートの宣言部分
  String toDeclarePython(indentLevel) {
    String temp = _block.toDeclarePython(indentLevel);
    if (temp.length > 0) {
      return _indent * indentLevel + temp;
    }
    return "";
  }


  /// RTM用に追加．RTCのonInitializeで呼ばれるaddOutPortなどを宣言するコードを生成
  String toBindPython(indentLevel) {
    String temp = _block.toBindPython(indentLevel);
    if (temp.length > 0) {
      return _indent * indentLevel + temp;
    }
    return "";
  }

  /// 内部のステートメントが保持する全てのブロックに対してfunc関数を適用するイテレータ
  void iterateBlock(var func) {
    func(_block);
    _block.iterateBlock(func);
  }

  /// XMLのコードを生成する
  void buildXML(xml.XmlBuilder builder) {
    builder.element('Statement',
        attributes: {
        },
        nest : () {
          block.buildXML(builder);

        });
  }

  /// XMLのノードがこのクラスのノードかどうかテストする
  static bool isClassXmlNode(xml.XmlNode node) {
    if (node is xml.XmlElement) {
      return (node.name.toString() == 'Statement');
    }
    return false;
  }

  /// XMLからデータを復元する
  /// BlockはどのクラスのBlockなのかわからないので，
  /// BlockLoaderクラスを使ってノードとクラスとの対応関係を動的に判断して
  /// オブジェクトを生成する
  Statement.XML(xml.XmlNode node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (childNode is xml.XmlElement) {
        var b = BlockLoader.parseBlock(childNode);
        if (b is Block) {
          this._block = b;
        }
      }
    });
  }
}


/// ステートメント (プログラムにおける文）を複数保持するためのリスト
/// リストの基本的な機能を実装してある
class StatementList extends ListMixin<Statement> {

  List<Statement> list = [];

  void set length(int newLength) {list.length = newLength;}

  int get length => list.length;

  Statement operator[](int index) => list[index];

  void operator[]=(int index, Statement value) {list[index] = value;}

  StatementList(List<Statement> l) {
    list.addAll(l);
  }

  /// ステートメントを加える．
  /// ステートメントの親要素にこのリスト自身を設定する
  void add(Statement child) {
    child.parent = this;
    list.add(child);
  }

  /// ステートメントを削除する
  /// ステートメントの親要素をnullにして循環参照を避ける
  @override
  bool remove(Statement child) {
    var b = super.remove(child);
    child.parent = null;
    return b;
  }

  /// ステートメントをindexの場所に挿入する
  /// ここでも親要素の設定を自分自身にする
  @override
  void insert(int index, Statement child) {
    super.insert(index, child);
    child.parent = this;
  }

  /// XMLを生成
  void buildXML(xml.XmlBuilder builder) {
    builder.element('Statements',
        attributes: {
        },
        nest : () {
          list.forEach((Statement s) {
            s.buildXML(builder);
          });
        });
  }

  /// 自クラスに対応するノードか否か判断
  bool isStatementListNode(xml.XmlNode node) {
    if (node is xml.XmlElement) {
      return (node.name.toString() == 'Statements');
    }
    return false;
  }

  /// XMLファイルからの復元
  void loadFromXML(xml.XmlNode node) {
    node.children.forEach((xml.XmlNode childNode) {
      if (Statement.isClassXmlNode(childNode)) {
        this.add(new Statement.XML(childNode));
      }
    });
  }


}