import 'dart:html' as html;
import 'package:core_elements/core_menu.dart';
import 'package:core_elements/core_drawer_panel.dart';
import 'package:core_elements/core_collapse.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_button.dart' as paper_button;
import 'collapse_menu.dart';
import 'add_element_button.dart';
import 'dart:async';
import '../controller/controller.dart';
import 'package:xml/xml.dart' as xml;

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

    $['file_input'].onChange.listen((var e) {
      onFileInput(e);
    });

    setMode('initialize');
  }

  void onMainPanelTap(var e) {
    //if (globalController.previousMouseEvent != e) {
      globalController.setSelectedElem(e, null);
    //}

    //$['main-panel'].querySelector('editor-panel').updateClick();
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
    $['condition_menu'].closeCollapse(null);
  }

  void setMode(String mode) {
    if (mode == 'initialize') {
      $['rtm_menu'].disableMenu(false);
      $['variables_menu'].disableMenu(false);
      ($['variables_menu'] as CollapseMenu).disableMenuItem('var0', false);
      ($['variables_menu'] as CollapseMenu).disableMenuItem('var1', true);
      ($['variables_menu'] as CollapseMenu).disableMenuItem('var2', true);
      $['port_data_menu'].disableMenu(true);
      $['calculate_menu'].disableMenu(true);
      $['if_switch_loop_menu'].disableMenu(true);
      $['condition_menu'].disableMenu(true);
    } else {
      $['rtm_menu'].disableMenu(true);
      $['variables_menu'].disableMenu(false);
      ($['variables_menu'] as CollapseMenu).disableMenuItem('var0', true);
      ($['variables_menu'] as CollapseMenu).disableMenuItem('var1', false);
      ($['variables_menu'] as CollapseMenu).disableMenuItem('var2', false);
      $['port_data_menu'].disableMenu(false);
      $['calculate_menu'].disableMenu(false);
      $['if_switch_loop_menu'].disableMenu(false);
      $['condition_menu'].disableMenu(false);
    }

    globalController.setMode(mode);
  }

  void onSave(var e) {
    var xml = globalController.buildXML();
    var text = xml.toXmlString(pretty: true);
    print(text);

    html.AnchorElement tl = new html.Element.tag('a');
    tl..attributes['href'] = 'data:text/plain;charset=utf-8,' + Uri.encodeComponent(text)
      ..attributes['download'] = 'rtm_block.xml'
      ..click();


  }

  void onImport(var e) {
    html.InputElement ie = $['file_input'];
    html.MouseEvent evt = new html.MouseEvent('click', canBubble: true,
        cancelable: true,
        view: html.window,
        detail: 0,
        screenX: 0,
        screenY: 0,
        clientX: 0,
        clientY: 0,
        ctrlKey: false,
        altKey: false,
        shiftKey: false,
        metaKey: false,
        button: 0,
        relatedTarget: null);
     ie.dispatchEvent(evt);
  }

  void onFileInput(var e) {
    html.InputElement ie = $['file_input'];
    print(ie.value);
    html.File file = ie.files[0];
    html.FileReader reader = new html.FileReader();
    reader.readAsText(file);
    reader.onLoad.listen((var e) {
      var doc = xml.parse(reader.result.toString());
      globalController.loadFromXML(doc);
      globalController.refreshAllPanel();
    });
  }

}