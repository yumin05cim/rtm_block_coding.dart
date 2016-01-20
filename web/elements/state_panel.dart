
import 'package:polymer/polymer.dart';
import 'dart:html' as html;
import 'package:rtm_block_coding/rtmtools.dart' as rtmtools;
import 'package:rtcprofile/rtcprofile.dart';
import '../controller/controller.dart';
import 'package:shape/shape.dart' as shape;
import 'dart:math' as math;

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

    rtcShape.strokeWidth = 0.5;
    rtcShape.strokeColor = new shape.Color(0xb6, 0xb6, 0xb6);
    rtcShape.bodyFillColor = new shape.Color(0xe8, 0x74, 0x61);
    rtcShape.draw(context, fill: true);

    showStateMachineImage(rtcProfile);
  }

  void showStateMachineImage(RTCProfile rtcProfile) {
    var margin = 40;
    _stateMachineCanvas = $['state-machine-canvas'];
    _stateMachineCanvas.height = 400 + margin*2;
    _stateMachineCanvas.width = 800;
    shape.CanvasDrawContext context = new shape.CanvasDrawContext(_stateMachineCanvas);

    int a_offset_x = 570;
    int a_offset_y = 40;
    int a_arc_radius = 40;
    int a_arc_width = 20;
        /*
    shape.Arc arc = new shape.Arc(new shape.Point2D(a_offset_x, a_offset_y + a_arc_radius), a_arc_radius,-math.PI/2, math.PI/2)
    ..strokeColor = new shape.Color.black();
    arc.draw(context, fill:false);

    shape.Arc arc2 = new shape.Arc(new shape.Point2D(a_offset_x, a_offset_y + a_arc_radius), a_arc_radius-a_arc_width, -math.PI/2, math.PI/2);
    arc2.draw(context, fill:false);
    */

    rtmtools.RTCProfileShape rtcShape = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 100, offset_y : margin);
    rtcShape.portHeight = 15; // Change size of RTC Image.
    rtcShape.strokeWidth = 1;
    rtcShape.strokeColor = new shape.Color(0xb6, 0xb6, 0xb6);
    rtcShape.bodyFillColor = new shape.Color(0x12, 0x12, 0xFF);
    rtcShape.draw(context, fill: true, notitle : true);

    rtmtools.RTCProfileShape rtcShape2 = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 400, offset_y : margin);
    rtcShape2.portHeight = 15; // Change size of RTC Image.
    rtcShape2.strokeWidth = 1;
    rtcShape2.strokeColor = new shape.Color(0xb6, 0xb6, 0xb6);
    rtcShape2.bodyFillColor = new shape.Color(0x12, 0xFF, 0x12);
    rtcShape2.draw(context, fill: true, notitle : true);


    var text = new shape.Text("停止中 (INACTIVE)",
        x: 100 + 15 * 4 / 2,
        y: margin-10,
        color: new shape.Color.black(),
        textAlign: 'center',
        font: '22px Arial');
    text.draw(context);

    text = new shape.Text("起動中 (ACTIVE)",
        x: 400 + 15 * 4 / 2,
        y: margin-10,
        color: new shape.Color.black(),
        textAlign: 'center',
        font: '22px Arial');
    text.draw(context, fill :false);

    shape.ArcArrow aa = new shape.ArcArrow(new shape.Point2D(a_offset_x, a_offset_y + a_arc_radius), a_arc_radius, -math.PI/2, math.PI*3/4, 20, 40)
      ..text = new shape.Text('onExecute', color: new shape.Color.black())
//      ..strokeColor = new shape.Color(0xb6, 0xb6, 0xb6)
      ..strokeWidth = 0.5
      ..fillColor = new shape.Color.fromString('#FFFF00');
    aa.draw(context, fill:true);

    shape.StraightArrow sa = new shape.StraightArrow(new shape.Point2D(200, 60), new shape.Point2D(370, 60))
      ..straightWidth = 20
      ..arrowWidth = 30
      ..text = new shape.Text('onActivated', color: new shape.Color.black())
//      ..strokeColor = new shape.Color(0xb6, 0xb6, 0x)
      ..strokeWidth = 0.5
      ..fillColor = new shape.Color.fromString('#FF00FF');
    sa.draw(context, fill:true);

    shape.StraightArrow sd = new shape.StraightArrow(new shape.Point2D(370, 100), new shape.Point2D(200, 100))
      ..straightWidth = 20
      ..arrowWidth = 30
      ..text = new shape.Text('onDectivated', color: new shape.Color.black())
//      ..strokeColor = new shape.Color(0xb6, 0xb6, 0xb6)
      ..strokeWidth = 0.5
      ..fillColor = new shape.Color.fromString('#00FFFF');
    sd.draw(context, fill:true);
  }


}