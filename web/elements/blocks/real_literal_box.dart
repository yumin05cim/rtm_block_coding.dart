import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'literal.dart';

@CustomTag('real-literal-box')
class RealLiteral extends Literal {

  program.RealLiteral _model;

  set model(program.RealLiteral m) {
    _model = m;
    value = m.value;
  }

  get model => _model;

  @published double value = 1.0;
  RealLiteral.created() : super.created();

  void attached() {
    $['real-literal-input'].onChange.listen((var e) {
      _model.value = value;
    });
  }

}
