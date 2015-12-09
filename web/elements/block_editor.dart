import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import 'package:rtm_block_coding/application.dart' as program;
import 'blocks/set_variable.dart';
import 'blocks/read_inport.dart';

import '../controller/controller.dart';

@CustomTag('block-editor')
class BlockEditor extends PolymerElement {

  @published String command;

  BlockEditor.created() : super.created();

  @override
  void attached() {

  }

  get container => $['container'];

  void refresh(program.Application app) {
    container.children.clear();
    app.statements.forEach((s) {
      parseStatement(s);
    });
  }

  void parseStatement(program.Statement s) {
    if(s.block is program.SetValue) {

      var il = new html.Element.tag('integer-literal')
        ..model = s.block.right;
      var sv = new html.Element.tag('set-variable')
        ..model = s.block
        ..attachTarget(il);
      container.children.add(sv);

    } else if(s.block is program.ReadInPort) {
      var ri = new html.Element.tag('read-inport')
        ..model = s.block;
      container.children.add(ri);
    }
  }

}