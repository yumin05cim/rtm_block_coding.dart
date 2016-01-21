
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

  RTCProfile _rtcProfile;
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

    if (mode == 'initialize') {
    } else if(mode == 'activated') {
      showStateMachineImage(_rtcProfile, activatedFillColor: new shape.Color.fromString('#e87461'),
          activatedStrokeColor: new shape.Color.fromString('#e86170'),
          activatedStrokeWidth: 4);
    } else if(mode == 'deactivated') {
      showStateMachineImage(_rtcProfile, deactivatedFillColor: new shape.Color.fromString('#e87461'),
          deactivatedStrokeColor: new shape.Color.fromString('#e86170'),
          deactivatedStrokeWidth: 4);
    } else if (mode == 'execute') {
      showStateMachineImage(_rtcProfile, executeFillColor: new shape.Color.fromString('#e87461'),
          executeStrokeColor: new shape.Color.fromString('#e86170'),
          executeStrokeWidth: 4);
    }
  }


  void showRTCImage(RTCProfile rtcProfile) {
    _rtcProfile = rtcProfile;
    var margin = 40;

    rtmtools.RTCProfileShape rtcShape = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 300, offset_y : margin);

    _interfaceCanvas = $['interface-canvas'];
    _interfaceCanvas.height = rtcShape.height + margin*2;
    _interfaceCanvas.width = 800;
    shape.CanvasDrawContext context = new shape.CanvasDrawContext(_interfaceCanvas);

    //rtcShape
    rtcShape.strokeWidth = 0.5;
    rtcShape.strokeColor = new shape.Color(0x32, 0x32, 0x32);
    rtcShape.bodyFillColor = new shape.Color(0xe8, 0x74, 0x61);
    rtcShape.draw(context, fill: true);

    var text = new shape.Text("RT-Component",
        x: 320 + 15 * 4 / 2,
        y: margin-10,
        color: new shape.Color.black(),
        textAlign: 'center',
        font: '18px Arial');
    text.draw(context);

    showStateMachineImage(rtcProfile);
  }


  static shape.Color defaultArrowColor = new shape.Color.fromString('#cacaca');
  static shape.Color defaultArrowStrokeColor = new shape.Color.fromString('#cacaca');
  static num defaultAllowStrokeWidth = 1;

  /// onActivated, onDeactivated, onExecuteタブが表示された場合の状態マシンの図を更新する
  /// @param rtcProfile RTCプロファイル
  /// @param activatedFillColor onAcitvatedの矢印のfillColorプロパティ．shape.Colorクラスのオブジェクト．nullを指定するとdefaultArrowColorメンバの値を参照する．
  /// @param deactivatedFillColor onDeacitvatedの矢印のfillColorプロパティ．shape.Colorクラスのオブジェクト．nullを指定するとdefaultArrowColorメンバの値を参照する．
  /// @param executeFillColor onExecuteの矢印のfillColorプロパティ．shape.Colorクラスのオブジェクト．nullを指定するとdefaultArrowColorメンバの値を参照する．
  void showStateMachineImage(RTCProfile rtcProfile, {
    shape.Color activatedFillColor : null,
    shape.Color deactivatedFillColor : null,
    shape.Color executeFillColor : null,
    shape.Color activatedStrokeColor : null,
    shape.Color deactivatedStrokeColor : null,
    shape.Color executeStrokeColor : null,
    num activatedStrokeWidth : null,
    num deactivatedStrokeWidth : null,
    num executeStrokeWidth : null}) {
    var margin = 40;

    rtmtools.RTCProfileShape rtcShape = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 100, offset_y : margin);
    rtmtools.RTCProfileShape rtcShape2 = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 400, offset_y : margin);

    _stateMachineCanvas = $['state-machine-canvas'];
    _stateMachineCanvas.height = rtcShape.height + 30 + margin*2;
    _stateMachineCanvas.width = 800;
    shape.CanvasDrawContext context = new shape.CanvasDrawContext(_stateMachineCanvas);

    int a_offset_x = 560;
    int a_offset_y = 40;
    int a_arc_radius = 40;
    int a_arc_width = 20;

    if (activatedFillColor == null) {
      activatedFillColor = defaultArrowColor;
    }
    if (deactivatedFillColor == null) {
      deactivatedFillColor = defaultArrowColor;
    }
    if (executeFillColor == null) {
      executeFillColor = defaultArrowColor;
    }

    if (activatedStrokeColor == null) {
      activatedStrokeColor = defaultArrowStrokeColor;
    }
    if (deactivatedStrokeColor == null) {
      deactivatedStrokeColor = defaultArrowStrokeColor;
    }
    if (executeStrokeColor == null) {
      executeStrokeColor = defaultArrowStrokeColor;
    }

    if (activatedStrokeWidth == null) {
      activatedStrokeWidth = defaultAllowStrokeWidth;
    }
    if (deactivatedStrokeWidth == null) {
      deactivatedStrokeWidth = defaultAllowStrokeWidth;
    }
    if (executeStrokeWidth == null) {
      executeStrokeWidth = defaultAllowStrokeWidth;
    }

        /*
    shape.Arc arc = new shape.Arc(new shape.Point2D(a_offset_x, a_offset_y + a_arc_radius), a_arc_radius,-math.PI/2, math.PI/2)
    ..strokeColor = new shape.Color.black();
    arc.draw(context, fill:false);

    shape.Arc arc2 = new shape.Arc(new shape.Point2D(a_offset_x, a_offset_y + a_arc_radius), a_arc_radius-a_arc_width, -math.PI/2, math.PI/2);
    arc2.draw(context, fill:false);
    */

//    RTC IMAGE
//    rtmtools.RTCProfileShape rtcShape = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 100, offset_y : margin);
    rtcShape.portHeight = 15; // Change size of RTC Image.
    rtcShape.strokeWidth = 1;
    rtcShape.strokeColor = new shape.Color(0x32, 0x32, 0x32);
    rtcShape.bodyFillColor = new shape.Color(0x12, 0x12, 0xFF);
    rtcShape.draw(context, fill: true, notitle : true);

//    rtmtools.RTCProfileShape rtcShape2 = new rtmtools.RTCProfileShape(rtcProfile, offset_x : 400, offset_y : margin);
    rtcShape2.portHeight = 15; // Change size of RTC Image.
    rtcShape2.strokeWidth = 1;
    rtcShape2.strokeColor = new shape.Color(0x32, 0x32, 0x32);
    rtcShape2.bodyFillColor = new shape.Color(0x12, 0xFF, 0x12);
    rtcShape2.draw(context, fill: true, notitle : true);

    var text = new shape.Text("停止中 (INACTIVE)",
        x: 100 + 15 * 4 / 2,
        y: margin-10,
        color: new shape.Color.black(),
        textAlign: 'center',
        font: '18px Arial');
    text.draw(context);

    text = new shape.Text("起動中 (ACTIVE)",
        x: 400 + 15 * 4 / 2,
        y: margin-10,
        color: new shape.Color.black(),
        textAlign: 'center',
        font: '18px Arial');
    text.draw(context, fill :false);

//    ALLOW TO EXPRESS STATE
    shape.ArcArrow aa = new shape.ArcArrow(new shape.Point2D(a_offset_x, a_offset_y + a_arc_radius), a_arc_radius, -math.PI/2, math.PI*3/4, 20, 40)
      ..text = new shape.Text('onExecute', color: new shape.Color.black())
      ..strokeColor = executeStrokeColor
      ..strokeWidth = executeStrokeWidth
      ..fillColor = executeFillColor;
    aa.draw(context, fill:true);

    shape.StraightArrow sa = new shape.StraightArrow(new shape.Point2D(200, 60), new shape.Point2D(370, 60))
      ..straightWidth = 20
      ..arrowWidth = 30
      ..text = new shape.Text('onActivated', color: new shape.Color.black())
      ..strokeColor = activatedStrokeColor
      ..strokeWidth = activatedStrokeWidth
      ..fillColor = activatedFillColor;
    sa.draw(context, fill:true);

    shape.StraightArrow sd = new shape.StraightArrow(new shape.Point2D(370, 100), new shape.Point2D(200, 100))
      ..straightWidth = 20
      ..arrowWidth = 30
      ..text = new shape.Text('onDectivated', color: new shape.Color.black())
      ..strokeColor = deactivatedStrokeColor
      ..strokeWidth = deactivatedStrokeWidth
      ..fillColor = deactivatedFillColor;
    sd.draw(context, fill:true);
  }


}