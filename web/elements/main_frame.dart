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

  MainFrame.created() :  super.created();

  @override
  void attached() {
    /*
    $['left-collapse-menu'].querySelectorAll('add-element-button').forEach(
        (var e) {e.controller = _controller;}
    );

    $['main-panel'].querySelectorAll('editor-panel').forEach(
        (var e) {e.controller = _controller;}
    );

    $['right-collapse-menu'].querySelectorAll('python-panel').forEach(
        (var e) {e.controller = _controller;}
    );
    */

    $['code-editor-panel'].setParent(this);

    $['main-panel'].onClick.listen(
        (var e) {
          if (globalController.previousMouseEvent != e) {
            globalController.setSelectedElem(e, null);
          }

          $['main-panel'].querySelector('editor-panel').updateClick();
        }
    );

    setMode('initialize');
  }


  void closeCollapse(var elem) {
    if (elem.opened) {
      elem.toggle();
    }
  }


  void closeAll() {
    $['rtm_menu'].closeCollapse(null);
    $['variables_menu'].closeCollapse(null);
    $['port_data_menu'].closeCollapse(null);
    $['calculate_menu'].closeCollapse(null);
    $['if_switch_loop_menu'].closeCollapse(null);
  }

  void setMode(String mode) {
    if (mode == 'initialize') {
      $['rtm_menu'].disableMenu(false);
      $['variables_menu'].disableMenu(true);
      $['port_data_menu'].disableMenu(true);
      $['calculate_menu'].disableMenu(true);
      $['if_switch_loop_menu'].disableMenu(true);
    } else {
      $['rtm_menu'].disableMenu(true);
      $['variables_menu'].disableMenu(false);
      $['port_data_menu'].disableMenu(false);
      $['calculate_menu'].disableMenu(false);
      $['if_switch_loop_menu'].disableMenu(false);
    }


  }

  void onSave(var e) {
    var xml = globalController.buildXML();
    print(xml.toXmlString(pretty: true));
  }
}