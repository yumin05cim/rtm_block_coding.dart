import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('smaller-than-box')
class SmallerThanBox extends ConditionsBox {

  static SmallerThanBox createBox() {
    return new html.Element.tag('smaller-than-box');
  }

  program.SmallerThan _model;

  String leftLabel;
  String rightLabel;

  set model(program.SmallerThan m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  SmallerThanBox.created() : super.created();

}

