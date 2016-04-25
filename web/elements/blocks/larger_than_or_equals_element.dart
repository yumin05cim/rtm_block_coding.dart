import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'conditions.dart';

@CustomTag('larger-than-or-equals-element')
class LargerThanOrEqualsElement extends ConditionalElement {

  program.LargerThanOrEquals _model;

  String leftLabel;
  String rightLabel;

  set model(program.LargerThanOrEquals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  LargerThanOrEqualsElement.created() : super.created();

}

