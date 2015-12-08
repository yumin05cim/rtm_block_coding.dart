import 'dart:html' as html;

import 'package:polymer/polymer.dart';

@CustomTag('set-variable')
class SetVariable extends PolymerElement {

  @published String name = "defaultName";
  SetVariable.created() : super.created();
}