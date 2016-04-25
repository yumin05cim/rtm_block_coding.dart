import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'conditions.dart';

@CustomTag('while-statement')
class While extends ConditionalElement {

  program.While _model;

  set model(program.While m) {
    _model = m;
  }

  get model => _model;

  get loop => $['loop-content'];

  While.created() : super.created();

}

