import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation_box.dart';
import '../block_editor.dart';

@CustomTag('subtraction-box')
class SubtractionBox extends CalculationBox {

  static SubtractionBox createBox(program.Subtract subtractBlock) {
    return (new html.Element.tag('subtraction-box') as SubtractionBox)
        ..model = subtractBlock
        ..attachLeft(BlockEditor.parseBlock(subtractBlock.a))
        ..attachRight(BlockEditor.parseBlock(subtractBlock.b));
  }

  program.Subtract _model;

  PolymerElement parentElement;

  set model(program.Subtract m) {
    _model = m;
  }

  get model => _model;

  SubtractionBox.created() : super.created();

}