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
      parseStatement(container.children, s);
    });

  }

  parseBlock(program.Block block) {
    if (block is program.Integer) {
      return new html.Element.tag('integer-literal')
        ..model = block;
    } else if (block is program.SetValue) {
      return new html.Element.tag('set-variable')
        ..model = block
        ..attachTarget(parseBlock(block.right));
    }
    else if (block is program.InPortDataAccess) {
      return new html.Element.tag('inport-data')
        ..model = block;
    } else if (block is program.ReadInPort) {
      var v = new html.Element.tag('read-inport')
        ..model = block;
      for (program.Statement s in block.statements) {
        parseStatement(v, s);
      }
      return v;
    }
  }


  void parseStatement(var children, program.Statement s) {
    children.add(parseBlock(s.block));
  }

}