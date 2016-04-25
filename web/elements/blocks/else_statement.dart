import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'conditions.dart';

@CustomTag('else-statement')
class Else extends ConditionalElement {

  program.Else _model;

  set model(program.Else m) {
    _model = m;
  }

  get model => _model;

  get alternative => $['alternative-content'];

  Else.created() : super.created();

}

