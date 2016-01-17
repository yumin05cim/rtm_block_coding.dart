

import 'package:polymer/polymer.dart';
import 'dart:html' as html;
import 'package:rtm_block_coding/rtmtools.dart' as rtmtools;
import 'package:rtcprofile/rtcprofile.dart';
import '../controller/controller.dart';
import 'package:shape/shape.dart' as shape;

@CustomTag('state-panel')
class StatePanel extends PolymerElement {
  StatePanel.created() :  super.created();

  html.CanvasElement _interfaceCanvas;
  html.CanvasElement _stateMachineCanvas;
  @override
  void attached() {

    showRTCImage(new RTCProfile());
    globalController.statePanel = this;

    _interfaceCanvas = $['interface-canvas'];
    _stateMachineCanvas  = $['state-machine-canvas'];

  }

  void setMode(String mode) {
    if (mode == 'initialize') {
      _interfaceCanvas.style.display = 'inline';
      _stateMachineCanvas.style.display = 'none';
    } else {
      _interfaceCanvas.style.display = 'none';
      _stateMachineCanvas.style.display = 'inline';
    }
  }

  void showRTCImage(RTCProfile rtcProfile) {
    var margin = 40;
    rtmtools.RTCProfileShape rtcShape = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 300, offset_y : margin);

    _interfaceCanvas = $['interface-canvas'];
    _interfaceCanvas.height = rtcShape.height + margin*2;
    _interfaceCanvas.width = 800;
    shape.CanvasDrawContext context = new shape.CanvasDrawContext(_interfaceCanvas);
    rtcShape.draw(context, fill: true);

    showStateMachineImage(rtcProfile);
  }

  void showStateMachineImage(RTCProfile rtcProfile) {
    var margin = 40;
    _stateMachineCanvas = $['state-machine-canvas'];
    _stateMachineCanvas.height = 400 + margin*2;
    _stateMachineCanvas.width = 800;
    shape.CanvasDrawContext context = new shape.CanvasDrawContext(_stateMachineCanvas);


    rtmtools.RTCProfileShape rtcShape = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 100, offset_y : margin);
    rtcShape.portHeight = 15; // Change size of RTC Image.
    rtcShape.bodyFillColor = new shape.Color(0x12, 0x12, 0xFF);
    rtcShape.draw(context, fill: true, notitle : true);

    rtmtools.RTCProfileShape rtcShape2 = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 300, offset_y : margin);
    rtcShape2.portHeight = 15; // Change size of RTC Image.
    rtcShape2.bodyFillColor = new shape.Color(0x12, 0xFF, 0x12);
    rtcShape2.draw(context, fill: true, notitle : true);

    rtmtools.RTCProfileShape rtcShape3 = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 500, offset_y : margin);
    rtcShape3.portHeight = 15; // Change size of RTC Image.
    rtcShape3.bodyFillColor = new shape.Color(0x12, 0x12, 0xFF);
    rtcShape3.draw(context, fill: true, notitle : true);

  }


}