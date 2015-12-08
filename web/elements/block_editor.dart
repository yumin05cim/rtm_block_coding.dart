import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import 'package:program_model/application.dart' as program;
import 'package:connection_model/connection.dart' as connect;
import 'package:connection_program_converter/converter.dart' as convert;
import 'blocks/set_variable.dart';

@CustomTag('block-editor')
class BlockEditor extends PolymerElement {

  @published String command;

  BlockEditor.created() : super.created();

  @override
  void attached() {

  }

  get container => $['container'];

  void forEachStatement(connect.Application app, var func) {
    connect.Statement s = app.startState;
    while(true) {
      if(s.next.connections.length > 0) {
        if(s.next == s.next.connections[0].ports[0]) {
          s = s.next.connections[0].ports[1].owner;
        } else {
          s = s.next.connections[0].ports[0].owner;
        }

        func(s);
      } else {
        return;
      }
    }

  }

  void refresh(program.Application app) {
    //command = app.toPython(0);


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