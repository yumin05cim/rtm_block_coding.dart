import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'conditions.dart';

@CustomTag('logical-not-element')
class NotElement extends ConditionalElement {

  program.Not _model;

  String leftLabel;
  String rightLabel;

  set model(program.Not m) {
    _model = m;
    condition = m.condition;
  }

  get model => _model;

  @published program.Condition condition = null;

  NotElement.created() : super.created();

}

