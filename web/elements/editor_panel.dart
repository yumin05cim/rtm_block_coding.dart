import 'package:polymer/polymer.dart';
import '../controller/controller.dart';
import 'block_editor.dart';
import 'dart:html' as html;

@CustomTag('editor-panel')
class EditorPanel extends PolymerElement {

  @observable var selected;

  EditorPanel.created() : super.created();

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
    switch (selected) {
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
  }

  get selectedEditor {
    switch (selected) {
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

  get selectedTab {
    switch (selected) {
      case 0:
        return $['on_initialize_tab'];
      case 1:
        return $['on_activated_tab'];
      case 2:
        return $['on_execute_tab'];
      case 3:
        return $['on_deactivated_tab'];
    }
    return null;
  }

  void onUpdateSelection() {
    if (globalController.selectedElement == null) {
      ($['up-button'] as html.HtmlElement).style.backgroundColor = '#CACACA';
      ($['down-button'] as html.HtmlElement).style.backgroundColor = '#CACACA';
      ($['remove-button'] as html.HtmlElement).style.backgroundColor =
      '#CACACA';
    } else {
      ($['up-button'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['down-button'] as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($['remove-button'] as html.HtmlElement).style.backgroundColor =
      '#A1CF6B';
    }
  }

  void onSelectTab() {
    if (selected == 0) {

    } else if (selected == 1) {

    } else if (selected == 2) {

    } else if (selected == 3) {

    }
  }

  void onSelectionUpdated(var e) {
  }


  void onSelectInitialize(var e) {
    parent.setMode('initialize');
  }

  void onSelectActivated(var e) {
    parent.setMode('activated');
  }

  void onSelectExecute(var e) {
    parent.setMode('execute');
  }

  void onSelectDeactivated(var e) {
    parent.setMode('deactivated');
  }

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