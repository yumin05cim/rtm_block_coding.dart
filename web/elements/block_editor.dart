import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import 'package:rtm_block_coding/application.dart' as program;
import 'blocks/set_variable.dart';

@CustomTag('block-editor')
class BlockEditor extends PolymerElement {

  @published String command;

  BlockEditor.created() : super.created();

  @override
  void attached() {

  }

  get container => $['container'];

  void refresh(program.Application app) {
    app.statements.forEach((s) {
      if(s.block is program.SetValue) {

        SetVariable il = new html.Element.tag('integer-literal')
          ..model = s.block.right
          ..value = s.block.right.value;
        SetVariable sv = new html.Element.tag('set-variable')
        ..model = s.block
        ..name = s.block.left.name
        ..attachTarget(il);


        container.children.add(sv);
      }
    });
  }
}