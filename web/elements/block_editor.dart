import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import 'package:rtm_block_coding/application.dart' as program;
import 'package:paper_elements/paper_fab.dart';
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

  void updateClick() {
    if (globalController.selectedElement == null) {
      $['up'].style.display = 'none';
      $['down'].style.display = 'none';
    } else {
      print((globalController.selectedElement as html.HtmlElement).offset.top);
      $['up'].style.display = 'inline';
      $['down'].style.display = 'inline';
      var height = (globalController.selectedElement as html.HtmlElement).clientHeight;
      if (height == 0) {
        var r = (globalController.selectedElement as PolymerElement).shadowRoot.children.forEach(
            (var e) {
              if (e is html.StyleElement) {
              } else {
                height = e.offset.height;
              }
            }
        );
      }

      var top = globalController.selectedElement.offset.top + height - 20;
      var left = globalController.selectedElement.offset.left + 100;
      $['up'].style.top = '${top}px';
      $['up'].style.left = '${left}px';

      $['down'].style.top = '${top}px';
      $['down'].style.left = '${left + 100}px';
    }
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
    } else if (block is program.OutPortData) {
      return new html.Element.tag('outport-data')
        ..model = block
        ..attachTarget(parseBlock(block.right));
    } else if (block is program.InPortDataAccess) {
      return new html.Element.tag('inport-data')
        ..model = block;
    } else if (block is program.ReadInPort) {
      var v = new html.Element.tag('read-inport')
        ..model = block;
      for (program.Statement s in block.statements) {
        parseStatement(v, s);
      }
      return v;
    } else if (block is program.OutPortWrite) {
      var v = new html.Element.tag('write-outport')
          ..model = block;
      return v;
    }
  }


  void parseStatement(var children, program.Statement s) {
    children.add(parseBlock(s.block));
  }

}