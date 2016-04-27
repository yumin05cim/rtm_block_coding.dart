import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'conditions_box.dart';

@CustomTag('if-box')
class IfBox extends ConditionsBox {

  static  IfBox createBox() {
    return new html.Element.tag('if-box');
  }

  program.If _model;

  set model(program.If m) {
    _model = m;
  }

  get model => _model;

  get consequent => $['consequent-content'];

  IfBox.created() : super.created();

}

