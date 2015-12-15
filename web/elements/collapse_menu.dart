import 'package:polymer/polymer.dart';
import 'dart:html' as html;
import 'package:core_elements/core_collapse.dart';


@CustomTag('collapse-menu')
class CollapseMenu extends PolymerElement {

  CollapseMenu.created() :  super.created();
  CoreCollapse coreCollapse;

  @published String label = 'title';
  @published String state = 'opened';
  @published String toolbarOpenColor = '#009688';
  @published String toolbarCloseColor = '#B2DFDB';

  @override
  void attached() {
    coreCollapse = $['coreCollapse'];

    if (state=='opened') {
      openCollapse(null);
    } else {
      closeCollapse(null);
    }
  }

  void openCollapse(var e) {
    if(!coreCollapse.opened) {
      coreCollapse.toggle();
    }
    state = 'opened';
    $['coreToolbar'].style.backgroundColor = toolbarOpenColor;
  }

  void closeCollapse(var e) {
    if(coreCollapse.opened) {
      coreCollapse.toggle();
    }
    state = 'closed';
    $['coreToolbar'].style.backgroundColor = toolbarCloseColor;
  }

  void toggleCollapse(var e) {
    coreCollapse.toggle();
    if (state == 'opened') {
      $['coreToolbar'].style.backgroundColor = toolbarCloseColor;
      state = 'closed';
    } else {
      $['coreToolbar'].style.backgroundColor = toolbarOpenColor;
      state = 'opened';
    }
  }

}