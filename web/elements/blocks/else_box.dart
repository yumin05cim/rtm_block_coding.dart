import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'conditions_box.dart';

@CustomTag('else-box')
class ElseBox extends ConditionsBox {

  static ElseBox createBox() {
    return new html.Element.tag('else-box');
  }

  program.Else _model;

  set model(program.Else m) {
    _model = m;
  }

  get model => _model;

  get alternative => $['alternative-content'];

  ElseBox.created() : super.created();

}

