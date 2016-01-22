import 'package:polymer/polymer.dart';
import '../controller/controller.dart';
import 'block_editor.dart';
import 'dart:html' as html;

@CustomTag('editor-panel')
class EditorPanel extends PolymerElement {

  @observable var selected;
  EditorPanel.created() :  super.created();

  var parent;

  void setParent(var parent) {
    this.parent = parent;
  }

  BlockEditor onInitializeEditor;
  BlockEditor onActivatedEditor;
  BlockEditor onDeactivatedEditor;
  BlockEditor onExecuteEditor;
  @override
  void attached() {
    selected = 0;
    globalController.editorPanel = this;
    onInitializeEditor = $['on_initialize_editor'];
    onActivatedEditor = $['on_activated_editor'];
    onDeactivatedEditor = $['on_deactivated_editor'];
    onExecuteEditor = $['on_execute_editor'];
  }

  get selectedApplication {
    switch(selected) {
      case 0:
        return globalController.onInitializeApp;
      case 1:
        return globalController.onActivatedApp;
      case 2:
        return globalController.onExecuteApp;
        break;
      case 3:
        return globalController.onDeactivatedApp;
    }
    return null;
  }


  void refresh() {
    selectedEditor.refresh(selectedApplication);
//    selectedTab.refresh(selectedApplication);
  }

    /*
  void refresh(var app) {
    selectedEditor.refresh(app);
  }

  void updateClick() {
    selectedEditor.updateClick();
  }
  */

  get selectedEditor {
    switch(selected) {
      case 0:
        return $['on_initialize_editor'];
      case 1:
        return $['on_activated_editor'];
      case 2:
        return $['on_execute_editor'];
      case 3:
        return $['on_deactivated_editor'];
    }
    return null;
  }

  void onUpdateSelection() {
    if (globalController.selectedElement == null) {
      ($['up-button'] as html.HtmlElement).style.backgroundColor = '#CACACA';
      ($['down-button'] as html.HtmlElement).style.backgroundColor = '#CACACA';
      ($['remove-button'] as html.HtmlElement).style.backgroundColor = '#CACACA';
    } else {
      ($['up-button'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['down-button'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['remove-button'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    }
  }

  void onSelectTab() {
    if(selected == 0) {

    } else if (selected == 1) {

    } else if (selected == 2) {

    } else if (selected == 3) {

    }
  }

  void onSelectInitialize(var e) {
/*
    ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';

    ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';

    ($['on_initialize_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
    ($['on_activated_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
    ($['on_deactivated_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    });
    ($['on_execute_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
*/

//    if(selected == 0) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
//    }
    ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    parent.setMode('initialize');
  }

  void onSelectActivated(var e) {
/*
    ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';

    ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';

    ($['on_activated_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
    ($['on_initialize_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
    ($['on_deactivated_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    });
    ($['on_execute_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
*/
//    select(selectedTab);
//    if(selected == 1) {
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
//    }
    ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    parent.setMode('activated');

  }

  void onSelectExecute(var e) {
/*
    ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';

    ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';

    ($['on_execute_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
    ($['on_initialize_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
    ($['on_activated_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    });
    ($['on_deactivated_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    });
*/
//    if(selected == 2) {
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
//    }
    ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    parent.setMode('execute');
  }

  void onSelectDeactivated(var e) {
/*
    ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';

    ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';

    ($['on_initialize_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    });
    ($['on_activated_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    });
    ($['on_execute_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    });
    ($['on_deactivated_tab'] as html.HtmlElement).onMouseOver.listen( (event) {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    });
*/
//    if(selected == 3) {
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
//    }
    ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    parent.setMode('deactivated');
  }

  void onInitializeMouseOver(var e) {
    if(selected == 0) {
    } else {
      ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    }
  }
  void onActivatedMouseOver(var e) {
    if(selected == 1) {
    } else {
      ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    }
  }
  void onExecuteMouseOver(var e) {
    if(selected == 2) {
    } else {
      ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    }
  }
  void onDeactivatedMouseOver(var e) {
    if(selected == 3) {
    } else {
      ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#89c344';
    }
  }

  void onInitializeMouseOut(var e) {
    ($['on_initialize_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
  }
  void onActivatedMouseOut(var e) {
    ($['on_activated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
  }
  void onExecuteMouseOut(var e) {
    ($['on_execute_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
  }
  void onDeactivatedMouseOut(var e) {
    ($['on_deactivated_tab'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
  }

/*  void select(var s){
    (s as html.HtmlElement).style.backgroundColor = '#89c344';
//    (selectedTab as html.HtmlElement).style.backgroundColor = '#89c344';
//    selectedTab.select();
  }

  void deselect(var s){
    (s as html.HtmlElement).style.backgroundColor = '#A1CF6B';
//    (selectedTab as html.HtmlElement).style.backgroundColor = '#A1CF6B';
//    selectedTab.deselect();
  }*/

  void onUp(var e) {
    selectedEditor.onUp(e);
    e.stopPropagation();
  }

  void onDown(var e) {
    selectedEditor.onDown(e);
    e.stopPropagation();
  }

  void onRemove(var e) {
    selectedEditor.onRemove(e);
    e.stopPropagation();
  }
}