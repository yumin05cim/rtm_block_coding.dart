import 'dart:html' as html;

import 'package:polymer/polymer.dart';

@CustomTag('integer-literal')
class IntegerLiteral extends PolymerElement {

  @published int value = 1;
  IntegerLiteral.created() : super.created();
}