import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('conditions-box')
class ConditionsBox extends PolymerElement {

  PolymerElement parentElement;

  ConditionsBox.created() : super.created();

  void attached() {
    this.onClick.listen(
        (var e) {
      globalController.setSelectedElem(e, this);
      e.stopPropagation();
    }
    );
  }

  void attachLeft(var e) {
    $['left-content'].children.clear();
    $['left-content'].children.add(e);
    e.parentElement = this;
  }

  void attachRight(var e) {
    $['right-content'].children.clear();
    $['right-content'].children.add(e);
    e.parentElement = this;
  }

  void attachCondition(var e) {
    $['condition-content'].children.clear();
    $['condition-content'].children.add(e);
    e.parentElement = this;
  }

  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();
  }

  void select() {
    $['target'].style.border = 'ridge';
    ($['target'] as html.HtmlElement).style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $['target'].style.border = '1px solid #B6B6B6';
  }

  bool is_container() {
    return false;
  }
}

