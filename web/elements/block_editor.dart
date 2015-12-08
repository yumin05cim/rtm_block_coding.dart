import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import '../../lib/application.dart' as program;
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
        SetVariable sv = new html.Element.tag('set-variable');
        sv.name = s.block.left.name;
        container.children.add(sv);
      }
    });
    print (p.toPython(0));
  }
}