import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('logical-not-box')
class LogicalNotBox extends ConditionsBox {

  static LogicalNotBox createBox() {
    return new html.Element.tag('logical-not-box');
  }

  program.Not _model;

  String leftLabel;
  String rightLabel;

  set model(program.Not m) {
    _model = m;
    condition = m.condition;
  }

  get model => _model;

  @published program.Condition condition = null;

  LogicalNotBox.created() : super.created();

}

