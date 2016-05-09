import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../block_editor.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('larger-than-box')
class LargerThanBox extends ConditionsBox {

  program.LargerThan _model;

  String leftLabel;
  String rightLabel;

  static LargerThanBox createBox(program.LargerThan m) {
    return new html.Element.tag('larger-than-box') as LargerThanBox
      ..model = m
      ..attachLeft(BlockEditor.parseBlock(m.left))
      ..attachRight(BlockEditor.parseBlock(m.right));
  }

  set model(program.LargerThan m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  LargerThanBox.created() : super.created();

}

