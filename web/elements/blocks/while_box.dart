import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'conditions_box.dart';

@CustomTag('while-box')
class WhileBox extends ConditionsBox {

  static WhileBox createBox() {
    return new html.Element.tag('while-box');
  }

  program.While _model;

  set model(program.While m) {
    _model = m;
  }

  get model => _model;

  get loop => $['loop-content'];

  WhileBox.created() : super.created();

}

