import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation_box.dart';
import '../block_editor.dart';
import '../block_parser.dart';

@CustomTag('division-box')
class DivisionBox extends CalculationBox {

  static DivisionBox createBox(program.Divide divideBlock) {
    return (new html.Element.tag('division-box') as DivisionBox)
      ..model = divideBlock
      ..attachLeft(BlockParser.parseBlock(divideBlock.a))
      ..attachRight(BlockParser.parseBlock(divideBlock.b));
  }

  program.Divide _model;

  set model(program.Divide m) {
    _model = m;
  }

  get model => _model;

  DivisionBox.created() : super.created();


}