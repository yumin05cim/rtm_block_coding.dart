import 'package:polymer/polymer.dart';
import '../controller/controller.dart';
import 'package:paper_elements/paper_button.dart';

@CustomTag('add-element-button')
class AddElementButton extends PolymerElement {

  AddElementButton.created() :  super.created();

  @published String label = 'title';
  @published String command = 'command';

  @override
  void attached() {}

  void onTap(var e) {
    globalController.addElement(this.command);
  }

  void setEnabled(bool flag) {
    PaperButton btn = $['main-button'];
    btn.disabled = !flag;
  }

}