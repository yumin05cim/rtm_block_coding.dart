import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'conditions.dart';

@CustomTag('if-statement')
class If extends ConditionalElement {

  program.If _model;

  set model(program.If m) {
    _model = m;
  }

  get model => _model;

  get consequent => $['consequent-content'];

  If.created() : super.created();

}

