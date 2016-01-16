import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import '../controller/controller.dart';

@CustomTag('python-panel')
class PythonPanel extends PolymerElement {


  @published String command;
  String mode = "initialize";

  void setMode(var m) {mode = m;
  onUpdateSelection();}

  PythonPanel.created() : super.created();

  void attached() {
    globalController.pythonPanel = this;
  }
  void onUpdateSelection() {
    String innerHtml = "";

    // 選択要素がある場合
    if (globalController.selectedElement != null) {

      var pattern = globalController.selectedElement.model.toPython(0);
      String html = globalController.pythonCode();

      if (pattern.length == 0) { // onAct, onDeact, onExeには該当コードがない
        pattern = globalController.selectedElement.model.toDeclarePython(0);
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
      } else { // onAct, onDeact, onExeに該当コードがある
        RegExp reg = new RegExp(r'\r\n|\r|\n', multiLine : true);
        pattern.split(reg).forEach((String p) {
          if (p.length > 0) {
            html = html.replaceAll(

                p, '<span class="selected">' + p + '</span>');
          }
        });
      }



      innerHtml = html;
    } else { // 選択要素が何もない時
      innerHtml = globalController.pythonCode();
    }

    innerHtml = applyMode(innerHtml);

    $['text-area'].innerHtml = innerHtml;

  }


  String applyMode(String text) {
    String pattern = text;
    // モードごとの背景ハイライトの設定

    RegExp reg = new RegExp(r'<div id="on-' + mode + '-block">', multiLine : true);
    print(reg);

    return pattern.replaceAll(reg, '<div id=on-"' + mode + '-block" class="highlight">');
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

    text = applyMode(text);
    $['text-area'].innerHtml = text;
    //text_buf = text;
  }

}