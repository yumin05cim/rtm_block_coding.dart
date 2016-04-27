import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('larger-than-or-equals-box')
class LargerThanOrEqualsBox extends ConditionsBox {

  static LargerThanOrEqualsBox createBox() {
    return new html.Element.tag('larger-than-or-equals-box');
  }

  program.LargerThanOrEquals _model;

  String leftLabel;
  String rightLabel;

  set model(program.LargerThanOrEquals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  LargerThanOrEqualsBox.created() : super.created();

}

