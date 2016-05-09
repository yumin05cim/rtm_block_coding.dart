import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../block_editor.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('larger-than-or-equals-box')
class LargerThanOrEqualsBox extends ConditionsBox {

  program.LargerThanOrEquals _model;

  String leftLabel;
  String rightLabel;

  static LargerThanOrEqualsBox createBox(program.LargerThanOrEquals m) {
    return new html.Element.tag('larger-than-or-equals-box') as LargerThanOrEqualsBox
      ..model = m
      ..attachLeft(BlockEditor.parseBlock(m.left))
      ..attachRight(BlockEditor.parseBlock(m.right));
  }

  set model(program.LargerThanOrEquals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  LargerThanOrEqualsBox.created() : super.created();

}

