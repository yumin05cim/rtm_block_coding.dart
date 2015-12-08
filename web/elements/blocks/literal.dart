import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart';
import 'package:polymer/polymer.dart';

@CustomTag('integer-literal')
class IntegerLiteral extends PolymerElement {

  IntegerLiteral model;
  @published int value = 1;
  IntegerLiteral.created() : super.created();

  void attached() {
    $['literal-input'].onChange.listen(
        (var e) {
          model.value = value;
        }

    );
  }
}