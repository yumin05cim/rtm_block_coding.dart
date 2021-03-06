import '../elements/editor_panel.dart';
import 'package:rtm_block_coding/application.dart' as program;
import 'package:xml/xml.dart' as xml;
import 'package:polymer/polymer.dart';
import 'dart:html' as html;

import '../elements/blocks/read_inport_box.dart';
import '../elements/blocks/inport_buffer_box.dart';
import '../elements/blocks/outport_buffer_box.dart';
import '../elements/blocks/write_outport_box.dart';
import '../elements/blocks/set_variable.dart';
import '../elements/blocks/declare_variable_box.dart';
import '../elements/blocks/assign_variable_box.dart';
import '../elements/blocks/refer_variable_box.dart';
import '../elements/blocks/addition_box.dart';
import '../elements/blocks/subtraction_box.dart';
import '../elements/blocks/multiplication_box.dart';
import '../elements/blocks/division_box.dart';
import '../elements/blocks/integer_literal_box.dart';
import '../elements/blocks/real_literal_box.dart';
import '../elements/blocks/if_box.dart';
import '../elements/blocks/else_box.dart';
import '../elements/blocks/while_box.dart';
import '../elements/state_panel.dart';
import '../elements/python_panel.dart';
import 'package:rtcprofile/rtcprofile.dart';

class Controller {

  program.Application onInitializeApp = new program.Application();
  program.Application onActivatedApp = new program.Application();
  program.Application onExecuteApp = new program.Application();
  program.Application onDeactivatedApp = new program.Application();
  EditorPanel _editorPanel;
  PythonPanel _pythonPanel;
  StatePanel _statePanel;

  String _mode = "on_initialize";

  set editorPanel(EditorPanel p) => _editorPanel = p;

  set pythonPanel(PythonPanel p) => _pythonPanel = p;

  set statePanel(StatePanel p) => _statePanel = p;

  Controller() {

  }

  void setMode(String mode) {
    _pythonPanel.setMode(mode);
    _statePanel.setMode(mode);
  }


  String getSelectedEditorPanelName() {
    switch(_editorPanel.selected) {
      case 0:
        return 'onInitialize';
      case 1:
        return 'onActivated';
      case 2:
        return 'onExecute';
      case 3:
        return 'onDeactivated';
      default:
        return null;
    }
  }

  program.Application getSelectedEditorApplication() {
    switch(_editorPanel.selected) {
      case 0:
        return onInitializeApp;
      case 1:
        return onActivatedApp;
      case 2:
        return onExecuteApp;
      case 3:
        return onDeactivatedApp;
      default:
        return null;
    }
  }

  var selectedElement = null;
  var previousMouseEvent = null;

  void setSelectedElem(var event, var elem) {
    previousMouseEvent = event;
    if (selectedElement != null) {
      selectedElement.deselect();
    }
    selectedElement = elem;
    if (selectedElement != null) {
      selectedElement.select();
    }

    _editorPanel.onUpdateSelection();
    _pythonPanel.onUpdateSelection();
  }

  program.Statement selectedStatement() {
    return selectedElement;
  }

  String getInPortName() {
    int counter = 0;
    String n = 'in$counter';

    while (onInitializeApp.find(program.AddInPort, name:n).length != 0) {
      counter++;
      n = 'in$counter';
    }

    return n;
  }

  String getOutPortName() {
    int counter = 0;
    String n = 'out$counter';

    while (onInitializeApp.find(program.AddOutPort, name: n).length != 0) {
      counter++;
      n = 'out$counter';
    }

    return n;
  }

  String getVariableName() {
    int counter = 0;
    String n = 'variable$counter';

    while (onInitializeApp.find(program.DeclareVariable, name: n).length != 0) {
      counter++;
      n = 'variable$counter';
    }

    return n;
  }

  void addElement(String command) {
    print('add ${command}');
    program.Application app;
    switch (_editorPanel.selected) {
      case 0:
        app = onInitializeApp;
        break;
      case 1:
        app = onActivatedApp;
        break;
      case 2:
        app = onExecuteApp;
        break;
      case 3:
        app = onDeactivatedApp;
        break;
    }

//  rtm_menu
    if(command == 'add_inport') {
      var n = getInPortName();
      program.AddInPort v = new program.AddInPort(n, new program.DataType.TimedLong());
      program.Statement new_s = new program.Statement(v);
      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
    }
    if(command == 'add_outport') {
      var n = getOutPortName();
      program.AddOutPort v = new program.AddOutPort(n, new program.DataType.TimedLong());
      program.Statement new_s = new program.Statement(v);
      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
    }

//  variables_menu
    if (command == 'declare_variable') {
      var n = getVariableName();
      program.DeclareVariable v = new program.DeclareVariable(n, new program.DataType.fromTypeName("long"));
      program.Statement new_s = new program.Statement(v);
      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
    }
    /*
    if (command == 'set_variable') {
      program.SetVariable v = new program.SetVariable(new program.Variable('name'), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
      else if (selectedStatement() is ReadInPort) {
        selectedStatement().model.statements.add(new_s);
      } else {
        if (selectedElement.parentElement is If) {
          bool found = false;
          for(program.Statement s in selectedElement.parentElement.model.yes) {
            if ( s.block == selectedElement.model) {
              found = true;
            }
          }
          if (found) {
            selectedElement.parentElement.model.yes.add(new_s);
          }

          found = false;
          for(program.Statement s in selectedElement.parentElement.model.no) {
            if ( s.block == selectedElement.model) {
              found = true;
            }
          }
          if (found) {
            selectedElement.parentElement.model.no.add(new_s);
          }
        }

        else if (selectedElement.parentElement is While) {
          bool found = false;
          for (program.Statement s in selectedElement.parentElement.model
              .loop) {
            if (s.block == selectedElement.model) {
              found = true;
            }
          }
          if (found) {
            selectedElement.parentElement.model.yes.add(new_s);
          }
        }
      }
    }
    */

    if (command == 'refer_variable') {
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (variableList.length > 0) {
        program.ReferVariable v = new program.ReferVariable(variableList[0].name, variableList[0].dataType);
        //program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          //app.statements.add(new_s);
        } else if (selectedElement.parentElement is AssignVariableBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        } else if (selectedElement.parentElement is AdditionBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        } else if (selectedElement.parentElement is SubtractionBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        } else if (selectedElement.parentElement is MultiplicationBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        } else if (selectedElement.parentElement is DivisionBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        }
      }
    }

    if (command == 'assign_variable') {
      var outPortList = onInitializeApp.find(program.AddOutPort);
      if (outPortList == null) {outPortList = [];}
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (outPortList.length + variableList.length > 0) {
        var firstAlternative = null;
        if (variableList.length > 0) {
          firstAlternative = new program.ReferVariable(variableList[0].name, variableList[0].dataType);
        } else {
          firstAlternative = new program.OutPortBuffer(outPortList[0].name, outPortList[0].dataType, '');
        }

        program.Assign v = new program.Assign(
            firstAlternative, new program.IntegerLiteral(1));
        program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          app.statements.add(new_s);
        }
        else if (selectedStatement() is ReadInPortBox) {
          selectedStatement().model.statements.add(new_s);
        } else if (selectedElement.parentElement is IfBox) {
          selectedElement.parentElement.model.statements.add(new_s);
        } else if (selectedElement.parentElement is WhileBox) {
          selectedElement.parentElement.model.yes.add(new_s);
        }
      }
    }


//  port_data_menu
    if(command == 'read_inport') {
      //var inPortMap = onInitializeApp.getInPortMap();
      var inPortList = onInitializeApp.find(program.AddInPort);
      if (inPortList.length == 0) return;

      if (selectedStatement() == null) {
          program.ReadInPort v = new program.ReadInPort(inPortList[0].name, inPortList[0].dataType);
          program.Statement new_s = new program.Statement(v);
          app.statements.add(new_s);
      }
    }

    if(command == 'inport_data') {
      List<program.AddInPort> inPortList = onInitializeApp.find(program.AddInPort);
      if (inPortList.length == 0) return;

      ///program.OutPortWrite v = new program.OutPortWrite(outPortList[0].name, outPortList[0].dataType);

      //var inPortMap = onInitializeApp.getInPortMap();
      //if (inPortMap.keys.length == 0) return;

      //var inports = globalController.inportList();
      //var defaultInPort = new program.ReadInPort(inPortList[0].name, inPortList[0].dataType);
      //if (inports.length > 0) {
      //  defaultInPort = inports[0];
      // }

      program.InPortBuffer v = new program.InPortBuffer(inPortList[0].name, inPortList[0].dataType, "");
      program.Statement new_s = new program.Statement(v);

/*      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
      else */
      if(selectedStatement() is AssignVariableBox) {
        selectedStatement().model.right = v;
      }
      else if (selectedStatement() is OutPortBufferBox) {
        (selectedStatement() as OutPortBufferBox).model.right = v;
      }
      else {
        PolymerElement elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          if (selectedElement.model == elem.parentElement.model.right) {
            elem.parentElement.model.right = v;
          } else {
            elem.parentElement.model.left = v;
          }
        } else if (elem.parentElement is AdditionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is SubtractionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is MultiplicationBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is DivisionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        }
      }
    }

    if (command == 'outport_data') {
      List<program.AddOutPort> outPortList = onInitializeApp.find(program.AddOutPort);
      if (outPortList == null) outPortList = [];
      if (outPortList.length == 0) return;

      //program.OutPortWrite v = new program.OutPortWrite(outPortList[0].name, outPortList[0].dataType);
      //program.AccessOutPort v = new program.AccessOutPort(outPortList[0].name, outPortList[0].dataType, '', new program.IntegerLiteral(1));
      program.OutPortBuffer v = new program.OutPortBuffer(outPortList[0].name, outPortList[0].dataType, '');


      //var outPortMap = onInitializeApp.getOutPortMap();
      //if (outPortMap.keys.length == 0) return;

      //program.OutPortData v = new program.OutPortData(outPortMap.keys.first, outPortMap[outPortMap.keys.first], '', new program.Integer(1));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        //app.statements.add(new_s);
      }
      /*
      else if (selectedStatement() is SetVariable) {
        selectedStatement().model.right = v;
      }
      */
      else if (selectedStatement() is AssignVariableBox) {
        selectedStatement().model.left = v;
      }
      else if (selectedStatement() is ReadInPortBox) {
        selectedStatement().model.statements.add(new_s);
      }
      else {
        if (selectedElement.parentElement is AssignVariableBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        }
      }
    }

    if(command == 'write_outport') {
      List<program.AddOutPort> outPortList = onInitializeApp.find(program.AddOutPort);
      if (outPortList.length == 0) return;

      program.WriteOutPort v = new program.WriteOutPort(outPortList[0].name, outPortList[0].dataType);
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
      else if (selectedStatement() is ReadInPortBox) {

        selectedStatement().model.statements.add(new_s);
      }
    }

//  calculate_menu
    if (command == 'int_literal') {
      program.IntegerLiteral v = new program.IntegerLiteral(1);
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
//        if (selectedStatement() is SetVariable) {
        selectedStatement().model.right = v;
      }
      else {
        PolymerElement elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
//          if (elem.parentElement is SetVariable) {
           elem.parentElement.model.right = v;
        } else if (elem.parentElement is AdditionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is SubtractionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is MultiplicationBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is DivisionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        }
      }
    }

    if (command == 'real_literal') {
      program.RealLiteral v = new program.RealLiteral(1.0);
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
        selectedStatement().model.right = v;
      }
      else {
        PolymerElement elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          elem.parentElement.model.right = v;
        } else if (elem.parentElement is AdditionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is SubtractionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is MultiplicationBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        } else if (elem.parentElement is DivisionBox) {
          if (elem.parentElement.model.a == elem.model) {
            elem.parentElement.model.a = v;
          } else {
            elem.parentElement.model.b = v;
          }
        }
      }
    }

    if (command == 'addition') {
      program.Add v = new program.Add(new program.IntegerLiteral(3), new program.IntegerLiteral(2));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
//        if (selectedStatement() is SetVariable) {
         selectedStatement().model.right = v;
      }
      else {
        PolymerElement elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
//          if (elem.parentElement is SetVariable) {
          elem.parentElement.model.right = v;
        }
      }
    }

    if (command == 'subtraction') {
      program.Subtract v = new program.Subtract(new program.IntegerLiteral(3), new program.IntegerLiteral(2));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
        selectedStatement().model.right = v;
      }
      else {
        PolymerElement elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          elem.parentElement.model.right = v;
        }
      }
    }

    if (command == 'multiplication') {
      program.Multiply v = new program.Multiply(new program.IntegerLiteral(3), new program.IntegerLiteral(2));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
        selectedStatement().model.right = v;
      }
      else {
        PolymerElement elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          elem.parentElement.model.right = v;
        }
      }
    }

    if (command == 'division') {
      program.Divide v = new program.Divide(new program.IntegerLiteral(3), new program.IntegerLiteral(2));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
        selectedStatement().model.right = v;
      }
      else {
        PolymerElement elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          elem.parentElement.model.right = v;
        }
      }
    }


//  if_switch_loop_menu
    if(command =='if') {
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (variableList.length > 0) {
        program.If v = new program.If(new program.Equals(
            new program.IntegerLiteral(1), new program.IntegerLiteral(1)), new program.StatementList([new program.Statement
            (new program.Assign(new program.ReferVariable(variableList[0].name, variableList[0].dataType), new program.IntegerLiteral(1)))]));
        //no:new program.StatementList([new program.Statement(new program.SetVariable(new program.Variable('variable1'), new program.IntegerLiteral(1)))]));
        program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          app.statements.add(new_s);
        } else if (selectedStatement() is ReadInPortBox) {
          selectedStatement().model.statements.add(new_s);
        } else {

        }
      }
    }

    if(command =='else') {
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (variableList.length > 0) {
        program.Else v = new program.Else(new program.StatementList([new program.Statement
            (new program.Assign(new program.ReferVariable(variableList[0].name, variableList[0].dataType), new program.IntegerLiteral(1)))]));
        //no:new program.StatementList([new program.Statement(new program.SetVariable(new program.Variable('variable1'), new program.IntegerLiteral(1)))]));
        program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          if (app.statements.length > 0) {
            if (app.statements.last.block is program.If) {
              app.statements.add(new_s);
            }
          }
        } else if (selectedElement is IfBox) {
          var index = (selectedStatement().parent as html.DivElement).children.indexOf(selectedElement);

          if (index >= 0) {
            (selectedElement.model as program.If).parent.parent.insert(index + 1, new_s);
          }
        } else {

        }
      }
    }

    if(command =='while') {
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (variableList.length > 0) {
        program.While v = new program.While(new program.Equals(new program.IntegerLiteral(1), new program.IntegerLiteral(1)), new program.StatementList([new program.Statement(
            new program.Assign(new program.ReferVariable(variableList[0].name, variableList[0].dataType), new program.IntegerLiteral(1)))]));
        program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          app.statements.add(new_s);
        }
      }
    }

//  condition_menu
    if(command == 'equals') {
      program.Equals v = new program.Equals(new program.IntegerLiteral(1), new program.IntegerLiteral(1));

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        selectedStatement().parentElement.model.condition = v;
      } else if(selectedElement is WhileBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        selectedStatement().parentElement.model.condition = v;
      }
    }

    if(command == 'not_equals') {
      program.NotEquals v = new program.NotEquals(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        selectedStatement().parentElement.model.condition = v;
      } else if(selectedElement is WhileBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        selectedStatement().parentElement.model.condition = v;
      }
    }

    if(command == 'larger') {
      program.LargerThan v = new program.LargerThan(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        selectedStatement().parentElement.model.condition = v;
      } else if(selectedElement is WhileBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        selectedStatement().parentElement.model.condition = v;
      }
    }

    if(command == 'larger_equals') {
      program.LargerThanOrEquals v = new program.LargerThanOrEquals(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        selectedStatement().parentElement.model.condition = v;
      } else if(selectedElement is WhileBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        selectedStatement().parentElement.model.condition = v;
      }
    }

    if(command == 'smaller') {
      program.SmallerThan v = new program.SmallerThan(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        selectedStatement().parentElement.model.condition = v;
      } else if(selectedElement is WhileBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        selectedStatement().parentElement.model.condition = v;
      }
    }

    if(command == 'smaller_equals') {
      program.SmallerThanOrEquals v = new program.SmallerThanOrEquals(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        selectedStatement().parentElement.model.condition = v;
      } else if(selectedElement is WhileBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        selectedStatement().parentElement.model.condition = v;
      }
    }

    if(command == 'logical_not') {
      program.Not v = new program.Not(new program.Equals(new program.IntegerLiteral(1), new program.IntegerLiteral(1)));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        selectedStatement().parentElement.model.condition = v;
      } else if(selectedElement is WhileBox) {
        selectedStatement().model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        selectedStatement().parentElement.model.condition = v;
      }
    }

    refreshPanel();
  }



  void refreshAllPanel({String except: ''}) {
    if (except != 'onInitialize') {
      _editorPanel.onInitializeEditor.refresh(onInitializeApp);
    }
    if (except != 'onActivated') {
      _editorPanel.onActivatedEditor.refresh(onActivatedApp);
    }
    if (except != 'onDeactivated') {
        _editorPanel.onDeactivatedEditor.refresh(onDeactivatedApp);
    }
    if (except != 'onExecute') {
        _editorPanel.onExecuteEditor.refresh(onExecuteApp);
    }

    _pythonPanel.onUpdateSelection();
    _statePanel.showRTCImage(getRTCProfile());
  }


  void refreshPanel() {
    /*
    program.Application app;
    switch (_editorPanel.selected) {
      case 0:
        app = onInitializeApp;
        break;
      case 1:
        app = onActivatedApp;
        break;
      case 2:
        app = onExecuteApp;
        break;
      case 3:
        app = onDeactivatedApp;
        break;
    }
    */
    _editorPanel.refresh();
    _pythonPanel.onUpdateSelection();
    _statePanel.showRTCImage(getRTCProfile());
  }

  String pythonCode({bool pure: false}) {

    var dec = onInitializeApp.toDeclarePython(2);
    //dec += onActivatedApp.toDeclarePython(2);
    //dec += onExecuteApp.toDeclarePython(2);
    //dec += onDeactivatedApp.toDeclarePython(2);

    var bin = onInitializeApp.toBindPython(2);
    //bin += onActivatedApp.toBindPython(2);
    //bin += onExecuteApp.toBindPython(2);
    //bin += onDeactivatedApp.toBindPython(2);

    var a = onActivatedApp.toPython(2);

    var e = onExecuteApp.toPython(2);

    var d = onDeactivatedApp.toPython(2);

    div(var id) {
      if (!pure) {
        return '<div id="$id">';
      }
      return '';
    }

    vid() {
      if (!pure) {
        return '</div>';
      }
      return '';
    }
    final string = """
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- Python -*-

import sys, time, traceback
sys.path.append(".")

# Import RTM module
import RTC
import OpenRTM_aist

block_rtc_spec = ["implementation_id", "BlockRTC",
    "type_name",         "BlockRTC",
    "description",       "RTM Block Coding Component",
    "version",           "1.0.0",
    "vendor",            "Ogata Lab Waseda Univ.",
    "category",          "Education",
    "activity_type",     "STATIC",
    "max_instance",      "1",
    "language",          "Python",
    "lang_type",         "SCRIPT",

    "conf.default.debug", "1",

    "conf.__widget__.debug", "text",

    ""]

class BlockRTC(OpenRTM_aist.DataFlowComponentBase):

  ${div('constructor')}
  def __init__(self, manager):
    OpenRTM_aist.DataFlowComponentBase.__init__(self, manager)
${dec}
    self._debug = [1]
  ${vid()}
  ${div("on-initialize-block")}
  def onInitialize(self):
    self.bindParameter("debug", self._debug, "1")
${bin}
    return RTC.RTC_OK
  ${vid()}
  ${div("on-activated-block")}
  def onActivated(self, ec_id):
${a}
    return RTC.RTC_OK
  ${vid()}
  ${div("on-deactivated-block")}
  def onDeactivated(self, ec_id):
${d}
    return RTC.RTC_OK
  ${vid()}
  ${div("on-execute-block")}
  def onExecute(self, ec_id):
${e}
    return RTC.RTC_OK
  ${vid()}

def BlockRTCInit(manager):
  profile = OpenRTM_aist.Properties(defaults_str=block_rtc_spec)
  manager.registerFactory(profile,
                          BlockRTC,
                          OpenRTM_aist.Delete)

def MyModuleInit(manager):
  BlockRTCInit(manager)
  comp = manager.createComponent("BlockRTC")

def main():
  mgr = OpenRTM_aist.Manager.init(sys.argv)
  mgr.setModuleInitProc(MyModuleInit)
  mgr.activateManager()
  mgr.runManager()

if __name__ == "__main__":
  main()


    """;
    return string;
  }


  List<program.ReadInPort> inportList() {
    var inports = [];
    var f = (var block) {
      if (block is program.ReadInPort) {
        inports.add(block);
      }
    };

    onActivatedApp.iterateBlock(f);
    onDeactivatedApp.iterateBlock(f);
    onExecuteApp.iterateBlock(f);

    return inports;
  }

  xml.XmlDocument buildXML() {
    xml.XmlBuilder builder = new xml.XmlBuilder();
    builder.processing(
        'xml', 'version="1.0" encoding="UTF-8" standalone="yes"');
    builder.element('RTMBlockCoding',
        attributes: {
        },
        nest: () {
          builder.element('onInitializeApp',
            nest : () {
              onInitializeApp.buildXML(builder: builder);
            });
          builder.element('onActivatedApp',
              nest : () {
                onActivatedApp.buildXML(builder: builder);
              });

          builder.element('onDeactivatedApp',
              nest : () {
                onDeactivatedApp.buildXML(builder: builder);
              });

          builder.element('onExecuteApp',
              nest : () {
                onExecuteApp.buildXML(builder: builder);
              });
        }

    );

    return builder.build();
  }

  void loadFromXML(xml.XmlDocument doc) {
    doc.children.forEach((xml.XmlNode node) {
      if (node is xml.XmlElement) {
        if (node.name.toString() == 'RTMBlockCoding') {
          node.children.forEach((xml.XmlNode childNode) {
            if (childNode is xml.XmlElement) {
              if (childNode.name.toString() == 'onInitializeApp') {
                childNode.children.forEach((xml.XmlNode gChildNode) {
                  if (program.Application.isClassXmlNode(gChildNode)) {
                    onInitializeApp.loadFromXML(gChildNode);
                  }
                });
              } else if (childNode.name.toString() == 'onActivatedApp') {
                childNode.children.forEach((xml.XmlNode gChildNode) {
                  if (program.Application.isClassXmlNode(gChildNode)) {
                    onActivatedApp.loadFromXML(gChildNode);
                  }
                });
//                  onActivatedApp.loadFromXML(childNode);
              } else if (childNode.name.toString() == 'onDeactivatedApp') {
                onDeactivatedApp.loadFromXML(childNode);
              } else if (childNode.name.toString() == 'onExecuteApp') {
                onExecuteApp.loadFromXML(childNode);
              }
            }
          });
        }
      }
    });
  }



  RTCProfile getRTCProfile() {
    var rtcp = new RTCProfile();
    List<program.AddInPort> inPortList = onInitializeApp.find(program.AddInPort);
    if (inPortList != null) {
      inPortList.forEach((program.AddInPort ip) {
        rtcp.addDataPorts(
            new DataPorts.InPort(name: ip.name, type: ip.dataType.typename));
      });
    }


    List<program.AddOutPort> outPortList = onInitializeApp.find(program.AddOutPort);
    if (outPortList != null) {
      outPortList.forEach((program.AddOutPort ip) {
        rtcp.addDataPorts(
            new DataPorts.OutPort(name: ip.name, type: ip.dataType.typename));
      });
    }
    return rtcp;

  }
}

Controller globalController = new Controller();