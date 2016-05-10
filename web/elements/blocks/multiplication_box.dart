import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation_box.dart';
import '../block_editor.dart';

@CustomTag('multiplication-box')
class MultiplicationBox extends CalculationBox {

  static MultiplicationBox createBox(program.Multiply multiplyBlock) {
    return (new html.Element.tag('multiplication-box') as MultiplicationBox)
      ..model = multiplyBlock
      ..attachLeft(BlockEditor.parseBlock(multiplyBlock.a))
      ..attachRight(BlockEditor.parseBlock(multiplyBlock.b));
  }

  program.Multiply _model;

  PolymerElement parentElement;

  set model(program.Multiply m) {
    _model = m;
  }

  get model => _model;

  MultiplicationBox.created() : super.created();

}