import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../block_editor.dart';
import '../block_parser.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('notequals-box')
class NotEqualsBox extends ConditionsBox {

  program.NotEquals _model;

  String leftLabel;
  String rightLabel;

  static NotEqualsBox createBox(program.NotEquals m) {
    return new html.Element.tag('notequals-box') as NotEqualsBox
      ..model = m
      ..attachLeft(BlockParser.parseBlock(m.left))
      ..attachRight(BlockParser.parseBlock(m.right));
  }

  set model(program.NotEquals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  NotEqualsBox.created() : super.created();

}

