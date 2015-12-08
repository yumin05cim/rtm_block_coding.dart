import 'package:polymer/polymer.dart';

import 'package:core_elements/core_collapse.dart';


@CustomTag('collapse-menu')
class CollapseMenu extends PolymerElement {

  CollapseMenu.created() :  super.created();
  CoreCollapse coreCollapse;

  @published String label = 'title';
  @published String state = 'opened';

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
  }

  void closeCollapse(var e) {
    if(coreCollapse.opened) {
      coreCollapse.toggle();
    }
    state = 'closed';
  }

  void toggleCollapse(var e) {
    coreCollapse.toggle();
    if (state == 'opened') {
      state = 'closed';
    } else {
      state = 'opened';
    }
  }

}