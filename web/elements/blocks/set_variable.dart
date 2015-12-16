import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'package:rtm_block_coding/application.dart';

@CustomTag('set-variable')
class SetVariable extends PolymerElement {
  SetValue _model;

  set model(SetValue m) {
    _model = m;
    name = _model.left.name;
  }

  get model => _model;

  @published String name = "defaultName";

    SetVariable.created() : super.created();

  void attached() {
    $['name-input'].onChange.listen(
        (var e) {
          _model.left.name = name;
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
    $['container'].style.border = 'ridge';
    ($['container'] as html.HtmlElement).style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $['container'].style.border = 'none';
  }

  bool is_container() {
    return false;
  }
}