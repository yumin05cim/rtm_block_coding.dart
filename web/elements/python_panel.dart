import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import '../controller/controller.dart';

@CustomTag('python-panel')
class PythonPanel extends PolymerElement {


  @published String command;

  PythonPanel.created() : super.created();

  void attached() {
    globalController.pythonPanel = this;
  }
  void onUpdateSelection() {
    if (globalController.selectedElement != null) {

      var pattern = globalController.selectedElement.model.toPython(0);
      String html = globalController.pythonCode();

      if (pattern.length == 0) {
        pattern = globalController.selectedElement.model.toDeclarePython(0);
        print ('Declare:' + pattern);
        if (pattern.length > 0) {
          RegExp reg = new RegExp(r'\r\n|\r|\n', multiLine : true);
          pattern.split(reg).forEach((String p) {
            if (p.length > 0) {
              html = html.replaceAll(
                  p, '<span class="selected">' + p + '</span>');
            }
          });

        }
        pattern = globalController.selectedElement.model.toBindPython(0);
        if (pattern.length > 0) {
          html = html.replaceAll(
              pattern, '<span class="selected">' + pattern + '</span>');
        }
      } else {
        RegExp reg = new RegExp(r'\r\n|\r|\n', multiLine : true);
        pattern.split(reg).forEach((String p) {
          if (p.length > 0) {
            html = html.replaceAll(

                p, '<span class="selected">' + p + '</span>');
          }
        });
      }
      $['text-area'].innerHtml = html;
    } else {
      $['text-area'].innerHtml = globalController.pythonCode();
    }

  }


  void onRefresh(var e) {
    String text = globalController.pythonCode();
    /*
    String html = '';
    RegExp reg = new RegExp(r'\r\n|\r|\n', multiLine : true);
    var lines = text.split(reg);
    print(lines);
    for(String line in lines) {
      html += line + '<br />';
    }
    */
    $['text-area'].innerHtml = text;
    //text_buf = text;
  }

}