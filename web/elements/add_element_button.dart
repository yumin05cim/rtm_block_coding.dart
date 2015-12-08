

import 'package:polymer/polymer.dart';



@CustomTag('add-element-button')
class AddElementButton extends PolymerElement {
  AddElementButton.created() :  super.created();

  @published String label = 'title';
  @published String command = 'command';

  @override
  void attached() {}

  void onTap(var e) {

  }

}