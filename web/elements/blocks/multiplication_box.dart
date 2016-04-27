import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation_box.dart';
import '../block_editor.dart';

@CustomTag('multiplication-box')
class Multiplication extends CalculationBox {

  static Multiplication createBox(program.Multiply multiplyBlock) {
    return (new html.Element.tag('multiplication-box') as Multiplication)
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

  Multiplication.created() : super.created();

}