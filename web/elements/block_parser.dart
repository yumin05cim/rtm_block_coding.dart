import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:rtm_block_coding/application.dart' as program;
import '../controller/controller.dart';

import 'blocks/add_inport_box.dart';
import 'blocks/add_outport_box.dart';
import 'blocks/declare_variable_box.dart';
import 'blocks/assign_variable_box.dart';
import 'blocks/refer_variable_box.dart';
import 'blocks/read_inport_box.dart';
import 'blocks/inport_buffer_box.dart';
import 'blocks/outport_buffer_box.dart';
import 'blocks/write_outport_box.dart';
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

@CustomTag('block-parser')
class BlockParser extends PolymerElement {

  BlockParser.created() : super.created();

  static parseBlock(program.Block block) {
    //  rtm_menu
    if (block is program.AddInPort) {
      return AddInPortBox.createBox(block);
    } else if (block is program.AddOutPort) {
      return AddOutPortBox.createBox(block);
    }

    //  variables_menu
    else if (block is program.DeclareVariable) {
      return DeclareVariableBox.createBox(block);
    } else if (block is program.Assign) {
      return AssignVariableBox.createBox(block);
    } else if (block is program.ReferVariable) {
      return ReferVariableBox.createBox(block);
    }
    /*    else if (block is program.SetVariable) {
      return new html.Element.tag('set-variable')
        ..model = block
        ..attachTarget(parseBlock(block.right));
    }*/

    //  port_data_menu
    else if (block is program.ReadInPort) {
      var v = ReadInPortBox.createBox(block);
      for (program.Statement s in block.statements) {
        parseStatement(v, s);
      }
      return v;
    } else if (block is program.InPortBuffer) {
      return InPortBufferBox.createBox(block);
    } else if (block is program.OutPortBuffer) {
      return OutPortBufferBox.createBox(block);
//      ..attachTarget(parseBlock(block.right));
    } else if (block is program.WriteOutPort) {
      return WriteOutPortBox.createBox(block);
    }

    //  calculate_menu
    else if (block is program.IntegerLiteral) {
      return IntegerLiteralBox.createBox(block);
    } else if (block is program.RealLiteral) {
      return RealLiteralBox.createBox(block);
    } else if (block is program.Add) {
      return AdditionBox.createBox(block);
    } else if (block is program.Subtract) {
      return SubtractionBox.createBox(block);
    } else if (block is program.Multiply) {
      return MultiplicationBox.createBox(block);
    } else if (block is program.Divide) {
      return DivisionBox.createBox(block);
    }

    //  if_switch_loop_menu
    else if (block is program.If) {
      var v = IfBox.createBox(block);
      for (program.Statement s_ in block.statements) {
        parseStatement(v.consequent.children, s_).parentElement = v;
      }
      return v;
    } else if (block is program.Else) {
      var v = ElseBox.createBox(block);
      for (program.Statement s_ in block.statements) {
        parseStatement(v.alternative.children, s_).parentElement = v;
      }
      return v;
    } else if (block is program.While) {
      var v = WhileBox.createBox(block);
      for (program.Statement s_ in block.statements) {
        parseStatement(v.loop.children, s_).parentElement = v;
      }
      return v;
    }

    //  condition_menu
    else if (block is program.Equals) {
      return EqualsBox.createBox(block);
    } else if (block is program.NotEquals) {
      return NotEqualsBox.createBox(block);
    } else if (block is program.LargerThan) {
      return LargerThanBox.createBox(block);
    } else if (block is program.LargerThanOrEquals) {
      return LargerThanOrEqualsBox.createBox(block);
    } else if (block is program.SmallerThan) {
      return SmallerThanBox.createBox(block);
    } else if (block is program.SmallerThanOrEquals) {
      return SmallerThanOrEqualsBox.createBox(block);
    } else if (block is program.Not) {
      return LogicalNotBox.createBox(block);
    }
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