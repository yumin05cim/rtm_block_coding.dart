
import 'package:rtcprofile/rtcprofile.dart' as rtcprofile;
import 'package:shape/shape.dart' as shape;

class RTCProfileShape extends shape.Shape2D {
  
  rtcprofile.RTCProfile rtcProfile;
  
  shape.Rectangle body = null;
  List<shape.Polygon> dataInPortShapes;
  List<shape.Polygon> dataOutPortShapes;
  List<shape.Rectangle> servicePortShapes;

  shape.Color bodyFillColor = new shape.Color(0xf3, 0x9c, 0x12);
  shape.Color portFillColor = new shape.Color(0xf1, 0xc4, 0x0f);
//  shape.Color bodyFillColor = new shape.Color(0x21, 0x96, 0xf3);
//  shape.Color portFillColor = new shape.Color(0xbb, 0xde, 0xfb);

  int _portHeight = 20;
  int textHeight = 18;
  int portWidth  = 30;
  int portMargin = 15;
  int padding = 20;
  int margin  = 20;
  int rtcWidth = 100;
  int textMargin = 10;
  

  get portHeight => _portHeight;

  set portHeight(int v) {
    _portHeight = v;
    textHeight = v * 0.9;
    portWidth  = v * 1.5;
    portMargin = portWidth / 2;
    padding = portHeight;
    margin = portHeight;
    rtcWidth = portHeight * 5;
    textMargin = margin /2;
  }

  num _offset_x = 0;
  num _offset_y = 0;
    
  RTCProfileShape(this.rtcProfile, {num offset_x : 0, num offset_y : 0}) {
    dataInPortShapes = new List<shape.Polygon>();
    dataOutPortShapes = new List<shape.Polygon>();
    servicePortShapes = new List<shape.Rectangle>();
    

    _offset_x = offset_x;
    _offset_y = offset_y;
  
  }
  
  shape.Shape2D translate(num x, num y) {
    return new RTCProfileShape(this.rtcProfile)
      .._offset_x = x
      .._offset_y = y;
  }

  int numRightPort;
  int numLeftPort;

  num get height {
    numLeftPort = 0;
    numRightPort = 0;
    rtcProfile.dataPorts.forEach((p) {
      if (p.portType == 'DataInPort') {
        numLeftPort++;
      } else {
        numRightPort++;
      }
    });
    rtcProfile.servicePorts.forEach((p) {
        numRightPort++;
    });

    int numPort = numLeftPort > numRightPort ? numLeftPort : numRightPort;
    return numPort * (portMargin+portHeight) - portMargin + padding*2;
  }
  
  void updateShape() {
    numLeftPort = 0;
    numRightPort = 0;
    rtcProfile.dataPorts.forEach((p) {
      if (p.portType == 'DataInPort') {
        numLeftPort++;
      } else {
        numRightPort++;
      }
    });
    rtcProfile.servicePorts.forEach((p) {
        numRightPort++;
    });

    int numPort = numLeftPort > numRightPort ? numLeftPort : numRightPort;

    numLeftPort = 0;
    numRightPort = 0;
    
    body = new shape.Rectangle(0+_offset_x, _offset_y, rtcWidth, numPort * (portMargin+portHeight) - portMargin + padding*2);
    body.fillColor = bodyFillColor;
    body.strokeColor = this.strokeColor;
    body.strokeWidth = this.strokeWidth;
 /*   
    var canvas = $['rtcp_canvas'] as html.CanvasElement;
    canvas.height = numPort * (portHeight+portMargin) + padding*2 + margin*2;
    canvas.width = 800;
    html.CanvasRenderingContext2D c2d = canvs.context2D;
      
        
        c2d.fillStyle = "#BBDEFB";
        
        c2d.fillRect(canvas.width/2-rtcWidth/2, margin,
             rtcWidth, numPort * (portMargin+portHeight) + padding);
        c2d.strokeRect(canvas.width/2-rtcWidth/2, margin,
            rtcWidth, numPort * (portMargin+portHeight) + padding);
*/
    
    rtcProfile.dataPorts.forEach((p) {
      if (p.portType == 'DataInPort') {
        List<shape.Point2D> points = new List<shape.Point2D>();
        shape.Point2D x0 = new shape.Point2D(_offset_x - portWidth/2,
            padding + numLeftPort*(portMargin+portHeight) + _offset_y);
        points.add(x0);
        points.add(new shape.Point2D(x0.x + portWidth, x0.y));
        points.add(new shape.Point2D(x0.x + portWidth, x0.y + portHeight));
        points.add(new shape.Point2D(x0.x, x0.y + portHeight));
        points.add(new shape.Point2D(x0.x + portWidth/3, x0.y + portHeight/2));


        dataInPortShapes.add(new shape.Polygon(points)
        ..fillColor = portFillColor
        ..strokeColor = this.strokeColor
        ..strokeWidth = this.strokeWidth);
        numLeftPort ++;
      } else {
        List<shape.Point2D> points = new List<shape.Point2D>();
        shape.Point2D x0 = new shape.Point2D(_offset_x + rtcWidth - portWidth/2,
            padding + numRightPort*(portMargin+portHeight) + _offset_y);
        points.add(x0);
        points.add(new shape.Point2D(x0.x + portWidth*2/3, x0.y));
        points.add(new shape.Point2D(x0.x + portWidth, x0.y + portHeight/2));
        points.add(new shape.Point2D(x0.x + portWidth*2/3, x0.y + portHeight));
        points.add(new shape.Point2D(x0.x, x0.y + portHeight));
        
        dataOutPortShapes.add(new shape.Polygon(points)
          ..fillColor = portFillColor
          ..strokeColor = this.strokeColor
          ..strokeWidth = this.strokeWidth);
        numRightPort++;
      }
    });
    
    rtcProfile.servicePorts.forEach((p) {
      servicePortShapes.add(new shape.Rectangle(_offset_x + rtcWidth - portWidth/2,
          padding + numRightPort*(portMargin+portHeight) + _offset_y,
          portWidth, portHeight)
        ..fillColor = portFillColor
        ..strokeColor = this.strokeColor
        ..strokeWidth = this.strokeWidth);
      numRightPort++;
    });
  }
  
  @override
  void draw(shape.DrawContext context, {fill: false, notitle: false}) {
    if(body == null) {
      updateShape();
    }

//    body.strokeColor = this.strokeColor; //added
    body.draw(context, fill: fill);
    
    for(int i = 0;i < dataInPortShapes.length;i++) {
      var p = dataInPortShapes[i];
      var port = rtcProfile.dataInPorts[i];

//      p.strokeColor = this.strokeColor;  //added
      p.draw(context, fill: fill);

      if(!notitle) {
        var text = new shape.Text("${port.name} : ${port.type}",
            x: p.points[0].x - textMargin,
            y: p.points[0].y,
            color: new shape.Color.black(),
            textAlign: 'right',
            font: '${textHeight}px Arial');
        text.draw(context);
      }
    }

    List<shape.Point2D> points = new List<shape.Point2D>();
    shape.Point2D x0 = new shape.Point2D(_offset_x + rtcWidth - portWidth/2,
        padding + numRightPort*(portMargin+portHeight) + _offset_y);
    points.add(x0);
    points.add(new shape.Point2D(x0.x + portWidth*2/3, x0.y));
    points.add(new shape.Point2D(x0.x + portWidth, x0.y + portHeight/2));
    points.add(new shape.Point2D(x0.x + portWidth*2/3, x0.y + portHeight));
    points.add(new shape.Point2D(x0.x, x0.y + portHeight));


    for(int i = 0;i < dataOutPortShapes.length;i++) {
      var p = dataOutPortShapes[i];
      var port = rtcProfile.dataOutPorts[i];
      p.draw(context, fill: fill);

      if (!notitle) {
        var text = new shape.Text("${port.name} : ${port.type}",
            x: p.points[0].x + textMargin + portWidth,
            y: p.points[0].y,
            color: new shape.Color.black(),
            textAlign: 'left',
            font: '${textHeight}px Arial');
        text.draw(context);
      }
    }
    
    for(int i = 0;i < servicePortShapes.length;i++) {
      var p = servicePortShapes[i];
      var port = rtcProfile.servicePorts[i];

      p.draw(context, fill: fill);

      if (!notitle) {
        var text = new shape.Text("${port.name}",
            x: p.x + textMargin + portWidth,
            y: p.y,
            color: new shape.Color.black(),
            textAlign: 'left',
            font: '${textHeight}px Arial');
        text.draw(context);
      }
    }
  }
}