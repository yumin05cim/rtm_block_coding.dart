import 'package:polymer/polymer.dart';
import 'dart:html' as html;
import 'package:core_elements/core_collapse.dart';


@CustomTag('collapse-menu')
class CollapseMenu extends PolymerElement {

  CollapseMenu.created() :  super.created();
  CoreCollapse coreCollapse;

  @published String label = 'title';
  @published String state = 'opened';
//  @published String toolbarOpenColor = '#AECE8C';
  @published String toolbarOpenColor = '#f2f2f2';
  @published String toolbarCloseColor = '#ffffff';
  @published String toolbarOpenTextColor = '#b42d50';
  @published String toolbarCloseTextColor = '#212121';
  @published String toolbarDisabledColor = '#B6B6B6';
  @published String toolbarDisabledTextColor = '#565656';


  get opened => coreCollapse.opened;

  bool disabled = false;

  void disableMenu(bool flag) {
    if(flag) {
      closeCollapse(null);


      $['coreToolbar'].style.backgroundColor = toolbarDisabledColor;
      $['coreToolbar'].style.color = toolbarDisabledTextColor;
      $['coreToolbar'].style.border = "1px groove #B6B6B6";

    } else {

      $['coreToolbar'].style.backgroundColor = toolbarCloseColor;
      $['coreToolbar'].style.color = toolbarCloseTextColor;
      $['coreToolbar'].style.border = "1px groove #B6B6B6";
    }
    disabled = flag;
  }

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
    if(disabled) {return;}

    if(!coreCollapse.opened) {
      coreCollapse.toggle();
    }
    state = 'opened';
    $['coreToolbar'].style.backgroundColor = toolbarOpenColor;
/*    $['coreToolbar'].style.backgroundColor = transparent;
    $['coreToolbar'].style.Color =toolbarOpenColor;*/

    $['coreToolbar'].style.color = toolbarOpenTextColor;
    $['coreToolbar'].style.border = "3px groove #B6B6B6";
  }

  void closeCollapse(var e) {
    if(disabled) {return;}

    if(coreCollapse.opened) {
      coreCollapse.toggle();
    }
    state = 'closed';
    $['coreToolbar'].style.backgroundColor = toolbarCloseColor;
    $['coreToolbar'].style.color = toolbarCloseTextColor;
    $['coreToolbar'].style.border = "1px groove #B6B6B6";

  }

  void toggleCollapse(var e) {
    if(disabled) {return;}

    coreCollapse.toggle();
    if (state == 'opened') {
      $['coreToolbar'].style.backgroundColor = toolbarCloseColor;
      $['coreToolbar'].style.color = toolbarCloseTextColor;
      $['coreToolbar'].style.border = "1px groove #B6B6B6";

      state = 'closed';
    } else {
      $['coreToolbar'].style.backgroundColor = toolbarOpenColor;
      $['coreToolbar'].style.color = toolbarOpenTextColor;
      $['coreToolbar'].style.border = "3px groove #B6B6B6";

      state = 'opened';
    }
  }

}