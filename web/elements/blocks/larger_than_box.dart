import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('larger-than-box')
class LargerThanBox extends ConditionsBox {

  static LargerThanBox createBox() {
    return new html.Element.tag('larger-than-box');
  }

  program.LargerThan _model;

  String leftLabel;
  String rightLabel;

  set model(program.LargerThan m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  LargerThanBox.created() : super.created();

}

