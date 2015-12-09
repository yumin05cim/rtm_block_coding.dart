import 'package:polymer/polymer.dart';
import '../controller/controller.dart';

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

}