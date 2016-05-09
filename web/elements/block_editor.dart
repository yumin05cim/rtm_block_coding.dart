import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import 'package:rtm_block_coding/application.dart' as program;
import 'package:paper_elements/paper_fab.dart';
import 'blocks/add_inport_box.dart';
import 'blocks/add_outport_box.dart';
import 'blocks/add_variable_box.dart';
import 'blocks/assign_variable_box.dart';
import 'blocks/refer_variable_box.dart';
import 'blocks/read_inport_box.dart';
import 'blocks/integer_literal_box.dart';
import 'blocks/real_literal_box.dart';
import 'blocks/addition_box.dart';
import 'blocks/subtraction_box.dart';
import 'blocks/multiplication_box.dart';
import 'blocks/division_box.dart';
import 'blocks/if_box.dart';
import 'blocks/else_box.dart';
import 'blocks/while_box.dart';
import 'blocks/equals_box.dart';
import 'blocks/notequals_box.dart';
import 'blocks/larger_than_box.dart';
import 'blocks/larger_than_or_equals_box.dart';
import 'blocks/smaller_than_box.dart';
import 'blocks/smaller_than_or_equals_box.dart';
import 'blocks/logical_not_box.dart';

import '../controller/controller.dart';

@CustomTag('block-editor')
class BlockEditor extends PolymerElement {

  @published String command;

  BlockEditor.created() : super.created();

  /*
  var up_offset = [-20, 100];
  var down_offset = [-20, 180];
  var delete_offset = [-20, 260];
  */

  @override
  void attached() {
  }

  void onClicked(var e) {
    globalController.setSelectedElem(e, globalController.selectedElement);
    e.stopPropagation();
  }

  /*
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
  */

  get container => $['container'];

  void refresh(program.Application app) {
    container.children.clear();
    app.statements.forEach((s) {
      parseStatement(container.children, s);
    });

  }

  static parseBlock(program.Block block) {

    //  rtm_menu
    if (block is program.AddInPort) {
      return AddInPortBox.createBox()
        ..model = block;
    } else if (block is program.AddOutPort) {
      return AddOutPortBox.createBox()
        ..model = block;
    }

    //  variables_menu
    else if (block is program.DeclareVariable) {
      return new html.Element.tag('add-variable-box')
        ..model = block;
    }
    else if (block is program.SetVariable) {
      return new html.Element.tag('set-variable')
        ..model = block
        ..attachTarget(parseBlock(block.right));
    }
    else if (block is program.Variable) {
      return new html.Element.tag('refer-variable-box')
        ..model = block;
    }
    else if (block is program.Assign) {
      return new html.Element.tag('assign-variable-box')
        ..model = block
        ..attachLeftTarget(parseBlock(block.left))
        ..attachRightTarget(parseBlock(block.right));
    }

    //  port_data_menu
    else if (block is program.AccessOutPort) {
      return new html.Element.tag('outport-data-box')
        ..model = block
        ..attachTarget(parseBlock(block.right));
    }
    else if (block is program.OutPortBuffer) {
      return new html.Element.tag('write-outport-box')
        ..model = block;
//        ..attachTarget(parseBlock(block.right));
    }
    else if (block is program.AccessInPort) {
      return new html.Element.tag('inport-data-box')
        ..model = block;
    } else if (block is program.ReadInPort) {
      var v = new html.Element.tag('read-inport-box')
        ..model = block;
      for (program.Statement s in block.statements) {
        parseStatement(v, s);
      }
      return v;
    } else if (block is program.WriteOutPort) {
      var v = new html.Element.tag('write-outport')
          ..model = block;
      return v;
    }

    //  calculate_menu
      else if (block is program.IntegerLiteral) {
      var v = IntegerLiteralBox.createBox()
        ..model = block;
      return v;
    } else if (block is program.RealLiteral) {
      var v = RealLiteralBox.createBox()
        ..model = block;
      return v;
    } else if (block is program.Add) {
/*      var v = new html.Element.tag('addition-box')
        ..model = block;

      v.attachLeft(parseBlock(block.a));
      v.attachRight(parseBlock(block.b));
      return v;*/
      return Addition.createBox(block);
    } else if (block is program.Subtract) {
/*      var v = new html.Element.tag('subtraction-box')
        ..model = block;

      v.attachLeft(parseBlock(block.a));
      v.attachRight(parseBlock(block.b));
      return v;*/
      return Subtraction.createBox(block);
    } else if (block is program.Multiply) {
/*      var v = new html.Element.tag('multiplication-box')
        ..model = block;

      v.attachLeft(parseBlock(block.a));
      v.attachRight(parseBlock(block.b));
      return v;*/
      return Multiplication.createBox(block);
    } else if (block is program.Divide) {
/*      var v = new html.Element.tag('division-box')
        ..model = block;

      v.attachLeft(parseBlock(block.a));
      v.attachRight(parseBlock(block.b));
      return v;*/
      return Division.createBox(block);
    }

    //  if_switch_loop_menu
      else if (block is program.If) {
      var v = IfBox.createBox()
        ..model = block;
      v.attachCondition(parseBlock(block.condition));
      for (program.Statement s_ in block.statements) {
        parseStatement(v.consequent.children, s_).parentElement = v;
      }
      return v;
    } else if (block is program.Else) {
      var v = ElseBox.createBox()
        ..model = block;
      for (program.Statement s_ in block.statements) {
        parseStatement(v.alternative.children, s_).parentElement = v;
      }
      return v;
    } else if (block is program.While) {
      var v = WhileBox.createBox()
        ..model = block;
      v.attachCondition(parseBlock(block.condition));
      for (program.Statement s_ in block.statements) {
        parseStatement(v.loop.children, s_).parentElement = v;
      }
      return v;
    }

    //  condition_menu
      else if (block is program.Equals) {
      var v = EqualsBox.createBox()
          ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    } else if (block is program.NotEquals) {
      var v =NotEqualsBox.createBox()
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    } else if (block is program.LargerThan) {
      var v = LargerThanBox.createBox()
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    } else if (block is program.LargerThanOrEquals) {
      var v = LargerThanOrEqualsBox.createBox()
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    } else if (block is program.SmallerThan) {
      var v = SmallerThanBox.createBox()
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    } else if (block is program.SmallerThanOrEquals) {
      var v = SmallerThanOrEqualsBox.createBox()
        ..model = block;
      v.attachLeft(parseBlock(block.left));
      v.attachRight(parseBlock(block.right));
      return v;
    } else if (block is program.Not) {
      var v = LogicalNotBox.createBox()
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
          //updateClick();
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
          //updateClick();
        }
      }
    }
  }

  void onRemove(var e) {
    var selected = globalController.selectedElement;
    if (selected == null) return;

    if (selected.parent == container) {
      var app = globalController.getSelectedEditorApplication();
      delete(app.statements, selected);
    }
    globalController.setSelectedElem(globalController.previousMouseEvent, null);
    globalController.refreshPanel();

    //updateClick();

  }

  static parseStatement(var children, program.Statement s) {
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