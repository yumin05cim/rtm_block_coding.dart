import '../elements/editor_panel.dart';
import 'package:rtm_block_coding/application.dart' as program;

import '../elements/blocks/read_inport.dart';
import '../elements/blocks/outport_data.dart';

import '../elements/blocks/set_variable.dart';

class Controller {

  program.Application onActivatedApp = new program.Application();
  program.Application onExecuteApp = new program.Application();
  program.Application onDeactivatedApp = new program.Application();
  EditorPanel _editorPanel;

  Controller() {
  }

  String getSelectedEditorPanelName() {
    switch(_editorPanel.selected) {
      case 0:
        return 'onActivated';
      case 1:
        return 'onExecute';
      case 2:
        return 'onDeactivated';
      default:
        return null;
    }
  }

  program.Application getSelectedEditorApplication() {
    switch(_editorPanel.selected) {
      case 0:
        return onActivatedApp;
      case 1:
        return onExecuteApp;
      case 2:
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
  }

  program.Statement selectedStatement() {
    return selectedElement;
  }

  void addElement(String command) {
    print('add ${command}');
    program.Application app;
    switch (_editorPanel.selected) {
      case 0:
        app = onActivatedApp;
        break;
      case 1:
        app = onExecuteApp;
        break;
      case 2:
        app = onDeactivatedApp;
        break;
    }

    if (command == 'set_variable') {

      program.SetValue v = new program.SetValue(new program.Variable('name'),
          new program.Integer(1));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }

      if (selectedStatement() is ReadInPort) {
        selectedStatement().model.statements.add(new_s);
      }
    }


    if (command == 'set_outport_data') {

      program.OutPortData v = new program.OutPortData('out', new program.DataType.TimedLong(), 'data',
          new program.Integer(1));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
      if (selectedStatement() is ReadInPort) {
        selectedStatement().model.statements.add(new_s);
      }
    }

    if(command == 'read_inport') {
      if (selectedStatement() == null) {
          program.ReadInPort v = new program.ReadInPort('in', new program.DataType.TimedLong());
          program.Statement new_s = new program.Statement(v);
          app.statements.add(new_s);
      }
    }

    if(command == 'write_outport') {
      program.OutPortWrite v = new program.OutPortWrite('out', new program.DataType.TimedLong());
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
      else if (selectedStatement() is ReadInPort) {
        selectedStatement().model.statements.add(new_s);
      }
    }

    if(command == 'inport_data') {
      var inports = globalController.inportList();
      var defaultInPort = new program.ReadInPort("in", new program.DataType.TimedLong());
      if (inports.length > 0) {
        defaultInPort = inports[0];
      }

      program.InPortDataAccess v = new program.InPortDataAccess(defaultInPort.name, new program.DataType.fromTypeName(defaultInPort.dataType.typename), "");
      if (selectedStatement() == null) {
        program.Statement new_s = new program.Statement(v);
        app.statements.add(new_s);
      }

      if (selectedStatement() is SetVariable) {
        selectedStatement().model.right = v;
      }

      if (selectedStatement() is OutPortData) {
        (selectedStatement() as OutPortData).model.right = v;
      }
    }

    if(command =='if') {
      program.If v = new program.If();
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
      else if (selectedStatement() is ReadInPort) {
        selectedStatement().model.statements.add(new_s);
      }

    }

    refreshPanel();
  }

  set editorPanel(EditorPanel p) => _editorPanel = p;

  void refreshPanel() {
    program.Application app;
    switch (_editorPanel.selected) {
      case 0:
        app = onActivatedApp;
        break;
      case 1:
        app = onExecuteApp;
        break;
      case 2:
        app = onDeactivatedApp;
        break;
    }
    _editorPanel.refresh(app);
  }

  String pythonCode() {
    var dec = onActivatedApp.toDeclarePython(2);
    dec += onExecuteApp.toDeclarePython(2);
    dec += onDeactivatedApp.toDeclarePython(2);

    var bin = onActivatedApp.toBindPython(2);
    dec += onExecuteApp.toBindPython(2);
    dec += onDeactivatedApp.toBindPython(2);

    var a = onActivatedApp.toPython(2);

    var e = onExecuteApp.toPython(2);

    var d = onDeactivatedApp.toPython(2);
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

  def __init__(self, manager):
    OpenRTM_aist.DataFlowComponentBase.__init__(self, manager)
${dec}
    self._debug = [1]

  def onInitialize(self):
    self.bindParameter("debug", self._debug, "1")
${bin}
    return RTC.RTC_OK

  def onActivated(self, ec_id):
${a}
    return RTC.RTC_OK

  def onDeactivated(self, ec_id):
${d}
    return RTC.RTC_OK

  def onExecute(self, ec_id):
${e}
    return RTC.RTC_OK

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
}

Controller globalController = new Controller();