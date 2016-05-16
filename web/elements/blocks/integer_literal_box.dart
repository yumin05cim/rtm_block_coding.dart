import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'literal_box.dart';

@CustomTag('integer-literal-box')
class IntegerLiteralBox extends LiteralBox {

  program.IntegerLiteral _model;

  static IntegerLiteralBox createBox(program.IntegerLiteral m) {
    return new html.Element.tag('integer-literal-box') as IntegerLiteralBox
      ..model = m;
  }

  set model(program.IntegerLiteral m) {
    _model = m;
    value = m.value;
  }

  get model => _model;

  @published int value = 1;
  IntegerLiteralBox.created() : super.created();

  void attached() {
    $['int-literal-input'].onChange.listen((var e) {
      _model.value = value;
    });
  }

}
