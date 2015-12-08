import 'package:polymer/polymer.dart';



@CustomTag('editor-panel')
class EditorPanel extends PolymerElement {
  @observable var selected;
  EditorPanel.created() :  super.created();

  @override
  void attached() {
    selected = 0;
  }
}