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

  var up_offset = [-20, 100];
  var down_offset = [-20, 180];
  var delete_offset = [-20, 260];

  @override
  void attached() {
    this.onClick.listen(
        (var e) {
          // To avoid the buggy behavior where the up-down buttons are vanished when clicked.
          globalController.setSelectedElem(e, globalController.selectedElement);
        }
    );
  }

  void updateClick() {
    if (globalController.selectedElement == null) {
      $['up'].style.display = 'none';
      $['down'].style.display = 'none';
      $['delete'].style.display = 'none';

    } else {
      $['up'].style.display = 'inline';
      $['down'].style.display = 'inline';
      $['delete'].style.display = 'inline';
      var height = (globalController.selectedElement as html.HtmlElement).clientHeight;
      if (height == 0) {
        (globalController.selectedElement as PolymerElement).shadowRoot.children.forEach(
            (var e) {
              if (e is html.StyleElement) {
              } else {
                height = e.offset.height;
              }
            }
        );
      }

      var top = globalController.selectedElement.offset.top + height;
      var left = globalController.selectedElement.offset.left;
      $['up'].style.top = '${top + up_offset[0]}px';
      $['up'].style.left = '${left + up_offset[1]}px';

      $['down'].style.top = '${top + down_offset[0]}px';
      $['down'].style.left = '${left + down_offset[1]}px';


      $['delete'].style.top = '${top + delete_offset[0]}px';
      $['delete'].style.left = '${left + delete_offset[1]}px';
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
    if (block is program.IntegerLiteral) {
      return new html.Element.tag('integer-literal')
        ..model = block;
    } else if (block is program.AddInPort) {
      return new html.Element.tag('add-inport')
        ..model = block;
    } else if (block is program.AddOutPort) {
      return new html.Element.tag('add-outport')
        ..model = block;
    } else if (block is program.SetVariable) {
      return new html.Element.tag('set-variable')
        ..model = block
        ..attachTarget(parseBlock(block.right));
    } else if (block is program.AccessOutPort) {
      return new html.Element.tag('outport-data')
        ..model = block
        ..attachTarget(parseBlock(block.right));
    } else if (block is program.AccessInPort) {
      return new html.Element.tag('inport-data')
        ..model = block;
    } else if (block is program.ReadInPort) {
      var v = new html.Element.tag('read-inport')
        ..model = block;
      for (program.Statement s in block.statements) {
        parseStatement(v, s);
      }
      return v;
    } else if (block is program.WriteOutPort) {
      var v = new html.Element.tag('write-outport')
          ..model = block;
      return v;
    } else if (block is program.IntegerLiteral) {
      var v = new html.Element.tag('integer-input')
        ..model = block;
      return v;
    } else if (block is program.Add) {
      var v = new html.Element.tag('calc-addition')
        ..model = block;

      v.attachLeft(parseBlock(block.a));
      v.attachRight(parseBlock(block.b));
      return v;
    } else if (block is program.Subtract) {
      var v = new html.Element.tag('calc-subtraction')
        ..model = block;

      v.attachLeft(parseBlock(block.a));
      v.attachRight(parseBlock(block.b));
      return v;
    } else if (block is program.Multiply) {
      var v = new html.Element.tag('calc-multiplication')
        ..model = block;

      v.attachLeft(parseBlock(block.a));
      v.attachRight(parseBlock(block.b));
      return v;
    }
    else if (block is program.Divide) {
      var v = new html.Element.tag('calc-division')
        ..model = block;

      v.attachLeft(parseBlock(block.a));
      v.attachRight(parseBlock(block.b));
      return v;
    }

    else if (block is program.If) {
      var v = new html.Element.tag('if-statement')
        ..model = block;
      v.attachCondition(parseBlock(block.condition));
      for (program.Statement s_ in block.statements) {
        parseStatement(v.yes.children, s_)
            .parentElement = v;
      }
      /*
      for (program.Statement s_ in block.no) {
        parseStatement(v.no.children, s_)
            .parentElement = v;
      }
      */
      return v;
    }
    else if (block is program.Else) {
      var v = new html.Element.tag('else-statement')
        ..model = block;
      for (program.Statement s_ in block.statements) {
        parseStatement(v.contents.children, s_)
            .parentElement = v;
      }
      /*
      for (program.Statement s_ in block.no) {
        parseStatement(v.no.children, s_)
            .parentElement = v;
      }
      */
      return v;
    }
    else if (block is program.While) {
      var v = new html.Element.tag('while-statement')
        ..model = block;
      v.attachCondition(parseBlock(block.condition));
      for (program.Statement s_ in block.loop) {
        parseStatement(v.loop.children, s_)
            .parentElement = v;
      }
      return v;
    }

    else if (block is program.Equals) {
      var v = new html.Element.tag('equals-element')
          ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    }
    else if (block is program.NotEquals) {
      var v = new html.Element.tag('notequals-element')
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    }
    else if (block is program.LargerThan) {
      var v = new html.Element.tag('larger-than-element')
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    }
    else if (block is program.LargerThanOrEquals) {
      var v = new html.Element.tag('larger-than-or-equals-element')
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    }
    else if (block is program.SmallerThan) {
      var v = new html.Element.tag('smaller-than-element')
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    }
    else if (block is program.SmallerThanOrEquals) {
      var v = new html.Element.tag('smaller-than-or-equals-element')
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    }
    else if (block is program.Not) {
      var v = new html.Element.tag('logical-not-element')
        ..model = block;
      v.attachCondition(parseBlock(block.condition));
      return v;
    }

  }


  void delete(program.StatementList slist, var elem) {
    var stat = null;
    slist.forEach(
        (var s) {
      if (s.block == elem.model) {
        stat = s;
      }
    }
    );
    if (stat != null) {
      slist.remove(stat);
    }
  }


  void onUp(var e) {
    var selected = globalController.selectedElement;
    if (selected == null) return;

    program.Statement s = selected.model.parent;
    if (s != null) {
      program.StatementList sl = s.parent;
      if (sl != null) {
        var index = sl.indexOf(s);
        index--;
        if (index >= 0) {
          sl.remove(s);
          sl.insert(index, s);

          globalController.setSelectedElem(globalController.previousMouseEvent, selected);
          globalController.refreshPanel();
          updateClick();
        }

      }
    }
  }

  void onDown(var e) {
    var selected = globalController.selectedElement;
    if (selected == null) return;


    program.Statement s = selected.model.parent;
    if (s != null) {
      program.StatementList sl = s.parent;
      if (sl != null) {
        var index = sl.indexOf(s);
        index++;
        if (index < sl.length) {
          sl.remove(s);
          sl.insert(index, s);

          globalController.setSelectedElem(globalController.previousMouseEvent, selected);
          globalController.refreshPanel();
          updateClick();
        }
      }
    }
  }

  void onDelete(var e) {
    var selected = globalController.selectedElement;
    if (selected == null) return;

    if (selected.parent == container) {
      var app = globalController.getSelectedEditorApplication();
      delete(app.statements, selected);
    }
    globalController.setSelectedElem(globalController.previousMouseEvent, null);
    globalController.refreshPanel();
    updateClick();

  }


  parseStatement(var children, program.Statement s) {
    var elem = parseBlock(s.block);
    if (globalController.selectedElement != null) {
      if (globalController.selectedElement.model == s.block) {
        globalController.setSelectedElem(
            globalController.previousMouseEvent, elem);
      }
    }
    children.add(elem);
    return elem;
  }

}