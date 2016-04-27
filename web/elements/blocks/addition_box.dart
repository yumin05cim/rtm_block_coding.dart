import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation.dart';
import '../block_editor.dart';

@CustomTag('addition-box')
class Addition extends Calculation {

/*
  static Addition createBox(program.Add addBlock) {
    return (new html.Element.tag('addition-box') as Addition)
      ..model = addBlock
      ..attachLeft(BlockEditor.parseBlock(addBlock.a))
      ..attachRight(BlockEditor.parseBlock(addBlock.b));
  }
*/

  program.Add _model;

  PolymerElement parentElement;

  set model(program.Add m) {
    _model = m;
  }

  get model => _model;

  Addition.created() : super.created();

}