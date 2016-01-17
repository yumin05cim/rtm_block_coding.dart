

import 'package:polymer/polymer.dart';
import 'dart:html' as html;
import 'package:rtm_block_coding/rtmtools.dart' as rtmtools;
import 'package:rtcprofile/rtcprofile.dart';
import '../controller/controller.dart';
import 'package:shape/shape.dart' as shape;

@CustomTag('state-panel')
class StatePanel extends PolymerElement {
  StatePanel.created() :  super.created();

  @override
  void attached() {

    showRTCImage(new RTCProfile());
    globalController.statePanel = this;

  }


  void showRTCImage(RTCProfile rtcProfile) {
    var margin = 40;
    rtmtools.RTCProfileShape rtcShape = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 250, offset_y : margin);
    var canvas = $['interface-canvas'] as html.CanvasElement;
    canvas.height = rtcShape.height + margin*2;
    canvas.width = 800;
    shape.CanvasDrawContext context = new shape.CanvasDrawContext(canvas);
    rtcShape.draw(context, fill: true);
  }


}