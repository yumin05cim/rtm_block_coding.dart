import '../elements/editor_panel.dart';
import 'package:rtm_block_coding/application.dart' as program;

import '../elements/blocks/read_inport.dart';

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

  connect.Statement last(connect.Application app){
    connect.Statement s = app.startState;
    while(true) {
      if(s.next.connections.length > 0) {
        if(s.next == s.next.connections[0].ports[0]) {
          s = s.next.connections[0].ports[1].owner;
        } else {
          s = s.next.connections[0].ports[0].owner;
        }
      } else {
        return s;
      }
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
      if (selectedStatement() == null) {
        program.SetValue v = new program.SetValue(new program.Variable('name'),
            new program.Integer(1));
        program.Statement new_s = new program.Statement(v);
        app.statements.add(new_s);
      }

      if (selectedStatement() is ReadInPort) {
        program.SetValue v = new program.SetValue(new program.Variable('name'),
            new program.Integer(1));
        program.Statement new_s = new program.Statement(v);
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
    return """
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- Python -*-

import sys, traceback
import time
import yaml
sys.path.append(".")

# Import RTM module
import RTC
import OpenRTM_aist

# Import Service implementation class
# <rtc-template block="service_impl">

# </rtc-template>

# Import Service stub modules
# <rtc-template block="consumer_import">
# </rtc-template>


# This module's spesification
# <rtc-template block="module_spec">
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
# </rtc-template>

##
# @class BlockComponent
# @brief RTM Block Coding Component
#
#
class BlockRTC(OpenRTM_aist.DataFlowComponentBase):

  ##
  # @brief constructor
  # @param manager Maneger Object
  #
  def __init__(self, manager):
    OpenRTM_aist.DataFlowComponentBase.__init__(self, manager)


    #self._d_velocity = RTC.TimedVelocity2D(RTC.Time(0,0), RTC.Velocity2D(0,0,0))


    #self._velocityIn = OpenRTM_aist.InPort("velocity", self._d_velocity)
${dec}


    # initialize of configuration-data.
    # <rtc-template block="init_conf_param">

    # - Name:  debug
    # - DefaultValue: 1
    self._debug = [1]

    # </rtc-template>



  ##
  #
  # The initialize action (on CREATED->ALIVE transition)
  # formaer rtc_init_entry()
  #
  # @return RTC::ReturnCode_t
  #
  #
  def onInitialize(self):

    # Bind variables and configuration variable
    self.bindParameter("debug", self._debug, "1")
    # Set InPort buffers
    #self.addInPort("velocity", self._velocityIn)
${bin}
    return RTC.RTC_OK

  #	##
  #	#
  #	# The finalize action (on ALIVE->END transition)
  #	# formaer rtc_exiting_entry()
  #	#
  #	# @return RTC::ReturnCode_t
  #
  #	#
  #def onFinalize(self, ec_id):
  #
  #	return RTC.RTC_OK

  #	##
  #	#
  #	# The startup action when ExecutionContext startup
  #	# former rtc_starting_entry()
  #	#
  #	# @param ec_id target ExecutionContext Id
  #	#
  #	# @return RTC::ReturnCode_t
  #	#
  #	#
  #def onStartup(self, ec_id):
  #
  #	return RTC.RTC_OK

  #	##
  #	#
  #	# The shutdown action when ExecutionContext stop
  #	# former rtc_stopping_entry()
  #	#
  #	# @param ec_id target ExecutionContext Id
  #	#
  #	# @return RTC::ReturnCode_t
  #	#
  #	#
  #def onShutdown(self, ec_id):
  #
  #	return RTC.RTC_OK

    ##
    #
    # The activated action (Active state entry action)
    # former rtc_active_entry()
    #
    # @param ec_id target ExecutionContext Id
    #
    # @return RTC::ReturnCode_t
    #
    #
  def onActivated(self, ec_id):
${a}
    return RTC.RTC_OK

    ##
    #
    # The deactivated action (Active state exit action)
    # former rtc_active_exit()
    #
    # @param ec_id target ExecutionContext Id
    #
    # @return RTC::ReturnCode_t
    #
    #
  def onDeactivated(self, ec_id):
${d}
    return RTC.RTC_OK

    ##
    #
    # The execution action that is invoked periodically
    # former rtc_active_do()
    #
    # @param ec_id target ExecutionContext Id
    #
    # @return RTC::ReturnCode_t
    #
    #
  def onExecute(self, ec_id):
${e}
    return RTC.RTC_OK

  #	##
  #	#
  #	# The aborting action when main logic error occurred.
  #	# former rtc_aborting_entry()
  #	#
  #	# @param ec_id target ExecutionContext Id
  #	#
  #	# @return RTC::ReturnCode_t
  #	#
  #	#
  #def onAborting(self, ec_id):
  #
  #	return RTC.RTC_OK

  #	##
  #	#
  #	# The error action in ERROR state
  #	# former rtc_error_do()
  #	#
  #	# @param ec_id target ExecutionContext Id
  #	#
  #	# @return RTC::ReturnCode_t
  #	#
  #	#
  #def onError(self, ec_id):
  #
  #	return RTC.RTC_OK

  #	##
  #	#
  #	# The reset action that is invoked resetting
  #	# This is same but different the former rtc_init_entry()
  #	#
  #	# @param ec_id target ExecutionContext Id
  #	#
  #	# @return RTC::ReturnCode_t
  #	#
  #	#
  #def onReset(self, ec_id):
  #
  #	return RTC.RTC_OK

  #	##
  #	#
  #	# The state update action that is invoked after onExecute() action
  #	# no corresponding operation exists in OpenRTm-aist-0.2.0
  #	#
  #	# @param ec_id target ExecutionContext Id
  #	#
  #	# @return RTC::ReturnCode_t
  #	#

  #	#
  #def onStateUpdate(self, ec_id):
  #
  #	return RTC.RTC_OK

  #	##
  #	#
  #	# The action that is invoked when execution context's rate is changed
  #	# no corresponding operation exists in OpenRTm-aist-0.2.0
  #	#
  #	# @param ec_id target ExecutionContext Id
  #	#
  #	# @return RTC::ReturnCode_t
  #	#
  #	#
  #def onRateChanged(self, ec_id):
  #
  #	return RTC.RTC_OK




def BlockRTCInit(manager):
  profile = OpenRTM_aist.Properties(defaults_str=block_rtc_spec)
  manager.registerFactory(profile,
                          BlockRTC,
                          OpenRTM_aist.Delete)

def MyModuleInit(manager):
  BlockRTCInit(manager)

  # Create a component
  comp = manager.createComponent("BlockRTC")

def main():
  mgr = OpenRTM_aist.Manager.init(sys.argv)
  mgr.setModuleInitProc(MyModuleInit)
  mgr.activateManager()
  mgr.runManager()

if __name__ == "__main__":
  main()


    """;
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