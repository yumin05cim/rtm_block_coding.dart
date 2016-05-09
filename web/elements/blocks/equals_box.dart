import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../block_editor.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('equals-box')
class EqualsBox extends ConditionsBox {

  program.Equals _model;

  String leftLabel;
  String rightLabel;

  static EqualsBox createBox(program.Equals m) {
    return new html.Element.tag('equals-box') as EqualsBox
      ..model = m
      ..attachLeft(BlockEditor.parseBlock(m.left))
      ..attachRight(BlockEditor.parseBlock(m.right));
  }

  set model(program.Equals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  EqualsBox.created() : super.created();

}

