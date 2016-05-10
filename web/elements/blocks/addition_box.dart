import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation_box.dart';
import '../block_editor.dart';

@CustomTag('addition-box')
class AdditionBox extends CalculationBox {

  static AdditionBox createBox(program.Add addBlock) {
    return (new html.Element.tag('addition-box') as AdditionBox)
      ..model = addBlock
      ..attachLeft(BlockEditor.parseBlock(addBlock.a))
      ..attachRight(BlockEditor.parseBlock(addBlock.b));
  }

  program.Add _model;

  PolymerElement parentElement;

  set model(program.Add m) {
    _model = m;
  }

  get model => _model;

  AdditionBox.created() : super.created();

}