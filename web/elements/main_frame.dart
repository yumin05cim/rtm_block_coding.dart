import 'dart:html' as html;
import 'package:core_elements/core_menu.dart';
import 'package:core_elements/core_drawer_panel.dart';
import 'package:core_elements/core_collapse.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_button.dart' as paper_button;
import 'collapse_menu.dart';
import 'add_element_button.dart';

import '../controller/controller.dart';

@CustomTag('main-frame')
class MainFrame extends PolymerElement {

  Controller _controller = new Controller();

  MainFrame.created() :  super.created();

  @override
  void attached() {
    $['left-collapse-menu'].querySelectorAll('add-element-button').forEach(
        (var e) {e.controller = _controller;}
    );

    $['main-panel'].querySelectorAll('editor-panel').forEach(
        (var e) {e.controller = _controller;}
    );

    $['right-collapse-menu'].querySelectorAll('python-panel').forEach(
        (var e) {e.controller = _controller;}
    );
  }

}