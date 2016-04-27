import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'literal_box.dart';

@CustomTag('integer-literal-box')
class IntegerLiteralBox extends LiteralBox {

  program.IntegerLiteral _model;

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
