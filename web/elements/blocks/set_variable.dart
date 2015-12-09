import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
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

    $['title-area'].onClick.listen(
        (var e) {
          globalController.setSelectedElem(e, this);

        }
    );
  }

  void attachTarget(var element) {
    $['target'].children.clear();
    $['target'].children.add(element);
  }

  void select() {
    this.style.border = 'solid';
  }

  void deselect() {
    this.style.border = 'none';
  }
}