import 'dart:html' as html;

import 'package:polymer/polymer.dart';

import 'package:rtm_block_coding/application.dart';

@CustomTag('set-variable')
class SetVariable extends PolymerElement {

  SetValue model;

  @published String name = "defaultName";
  SetVariable.created() : super.created();

  void attached() {
    $['name-input'].onChange.listen(
        (var e) {
          model.left.name = name;
        }
    );
  }

  void attachTarget(var element) {
    $['target'].children.clear();
    $['target'].children.add(element);
  }

}