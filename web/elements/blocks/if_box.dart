import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'conditions.dart';

@CustomTag('if-box')
class If extends ConditionalElement {

  static  If createBox() {
    return new html.Element.tag('if-box');
  }

  program.If _model;

  set model(program.If m) {
    _model = m;
  }

  get model => _model;

  get consequent => $['consequent-content'];

  If.created() : super.created();

}

