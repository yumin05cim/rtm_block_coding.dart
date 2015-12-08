import 'package:polymer/polymer.dart';
import '../controller/controller.dart';

@CustomTag('add-element-button')
class AddElementButton extends PolymerElement {
  Controller _controller;
  set controller(Controller c) => _controller = c;

  AddElementButton.created() :  super.created();

  @published String label = 'title';
  @published String command = 'command';

  @override
  void attached() {}

  void onTap(var e) {
    _controller.addElement(this.command);
  }

}