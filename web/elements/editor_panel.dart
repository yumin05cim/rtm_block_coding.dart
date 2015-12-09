import 'package:polymer/polymer.dart';
import '../controller/controller.dart';
import 'block_editor.dart';

@CustomTag('editor-panel')
class EditorPanel extends PolymerElement {

  @observable var selected;
  EditorPanel.created() :  super.created();

  @override
  void attached() {
    selected = 0;
    globalController.editorPanel = this;


  }

  void refresh(var app) {
    BlockEditor editor;
    switch(selected) {
      case 0:
        editor = $['on_activated_editor'];
        break;
      case 1:
        editor = $['on_execute_editor'];
        break;
      case 2:
        editor = $['on_deactivated_editor'];
        break;
    }

    editor.refresh(app);

  }

}