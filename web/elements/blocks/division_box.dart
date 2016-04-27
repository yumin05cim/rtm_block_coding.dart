import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation_box.dart';
import '../block_editor.dart';

@CustomTag('division-box')
class Division extends CalculationBox {

  static Division createBox(program.Divide divideBlock) {
    return (new html.Element.tag('division-box') as Division)
      ..model = divideBlock
      ..attachLeft(BlockEditor.parseBlock(divideBlock.a))
      ..attachRight(BlockEditor.parseBlock(divideBlock.b));
  }

  program.Divide _model;

  PolymerElement parentElement;

  set model(program.Divide m) {
    _model = m;
  }

  get model => _model;

  Division.created() : super.created();


}