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

  void refresh(var app) {
    selectedEditor.refresh(app);
  }

  void updateClick() {
    selectedEditor.updateClick();
  }

  get selectedEditor {
    BlockEditor editor;
    switch(selected) {
      case 0:
        editor = $['on_initialize_editor'];
        break;
      case 1:
        editor = $['on_activated_editor'];
        break;
      case 2:
        editor = $['on_execute_editor'];
        break;
      case 3:
        editor = $['on_deactivated_editor'];
        break;
    }
    return editor;
  }

  void onSelectInitialize(var e) {
    parent.setMode('initialize');
  }

  void onSelectActivated(var e) {
    parent.setMode('activated');
  }

  void onSelectDeactivated(var e) {
    parent.setMode('deactivated');
  }

  void onSelectExecute(var e) {
    parent.setMode('execute');
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
    selectedEditor.onDelete(e);
    e.stopPropagation();
  }
}