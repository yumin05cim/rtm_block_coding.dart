library application.base;

/// ブロックコーディングの大元の要素「アプリケーション」を定義するファイル
/// ブロックコーディングは，複数の文（ステートメント）から成り立っている
/// 文はブロックの要素の組み合わせで成り立っており，
/// 複数の文を管理するクラスをアプリケーションと呼ぶことにする

import 'dart:core';
import 'package:xml/xml.dart' as xml;
import 'statement.dart';
import 'block.dart';
import 'datatype.dart';
import 'inport.dart';
import 'outport.dart';
import 'dart:mirrors';


/// ブロックコーディングの大元の要素
class Application {

  /// ステートメント (文) のリスト
  /// このリストは単にステートメントを複数，順序も合わせて保持するだけのリスト
  StatementList statements = new StatementList([]);

  /// コンストラクタ
  Application() {
  }

  /// Pythonコードの生成．
  /// indentLevelでこのアプリケーション自体のPythonにおけるインデントレベルが決められる
  /// これは，アプリケーションが，さらにアプリケーションの中に入っているような
  /// 入れ子構造を想定している
  String toPython(int indentLevel) {
    String sb = "";
    for (Statement s in statements) {
      sb = sb + s.toPython(indentLevel) +  '\n';
    }
    return sb;
  }

  /// RTM用に追加．RTCのコンストラクタで呼ばれるデータポートの宣言部分
  String toDeclarePython(int indentLevel) {
    String sb = "";
    for (Statement s in statements) {
      String temp = s.toDeclarePython(indentLevel);
      if (temp.length > 0) {
        sb += temp + '\n';
      }
    }
    return sb;
  }

  /// RTM用に追加．RTCのonInitializeで呼ばれるaddOutPortなどを宣言するコードを生成
  String toBindPython(int indentLevel) {
    String sb = "";
    for (Statement s in statements) {
      String temp = s.toBindPython(indentLevel);
      if (temp.length > 0) {
        sb += temp + '\n';
      }
    }
    return sb;
  }

  /// 内部のステートメントが保持する全てのブロックに対してfunc関数を適用するイテレータ
  void iterateBlock(var func) {
    for(Statement s in statements) {
      s.iterateBlock(func);
    }
  }

  /// typenameで定義されるタイプのブロック要素をリストとして返す関数．
  /// たとえば内部のAdd要素全てを収集するのに使える
  /// またname引数を使えば，もし探し当てたブロックにnameというメンバがある場合
  /// nameが等しいか否かでフィルタリングをすることができる
  find(Type typename, {String name: null}) {
    var ret = [];

    iterateBlock(
        (Block b) {
          if (b.runtimeType == typename) {
            if(name == null) {
              ret.add(b);
            }
            else if(b.name == name) {
              ret.add(b);
            }
          }
    });

    if(name == null && ret.length == 0) {
      return null;
    }
    return ret;
  }

  /// XMLのコードを生成する
  void buildXML({xml.XmlBuilder builder : null}) {
    if (builder == null) {
      builder = new xml.XmlBuilder();
      builder.processing('xml', 'version="1.0" encoding="UTF-8" standalone="yes"');
    }

    builder.element('Application',
        attributes: {
          'version': '1.0',
        },
        nest : () {
          statements.buildXML(builder);
        });
  }

  /// XMLのノードがこのクラスのノードかどうかテストする
  static bool isClassXmlNode(xml.XmlNode node) {
    if (node is xml.XmlElement) {
      return (node.name.toString() == 'Application');
    }
    return false;
  }

  /// XMLからデータを復元する
  /// nodeはApplicationのノードのはずなので，
  /// その子要素それぞれをステートメントのノードと判断して，
  /// ステートメントを復元する．
  void loadFromXML(xml.XmlElement node) {
    statements.clear();
    node.children.forEach((xml.XmlNode childNode) {
      if (statements.isStatementListNode(childNode)) {
        statements.loadFromXML(childNode);
      }
    });
  }

}