import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'conditions.dart';

@CustomTag('smaller-than-or-equals-element')
class SmallerThanOrEqualsElement extends ConditionalElement {

  program.SmallerThanOrEquals _model;

  String leftLabel;
  String rightLabel;

  set model(program.SmallerThanOrEquals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  SmallerThanOrEqualsElement.created() : super.created();

}

