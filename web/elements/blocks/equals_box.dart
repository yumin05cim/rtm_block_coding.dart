import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('equals-box')
class EqualsBox extends ConditionsBox {

  static EqualsBox createBox() {
    return new html.Element.tag('equals-box');
  }

  program.Equals _model;

  String leftLabel;
  String rightLabel;

  set model(program.Equals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  EqualsBox.created() : super.created();

}

