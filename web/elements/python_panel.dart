import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import '../controller/controller.dart';

@CustomTag('python-panel')
class PythonPanel extends PolymerElement {


  @published String command;

  PythonPanel.created() : super.created();

  void onRefresh(var e) {
    $['text-area'].text = globalController.pythonCode();
  }

}