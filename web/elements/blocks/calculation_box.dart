import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('calculation-box')
class CalculationBox extends PolymerElement {

  PolymerElement parentElement;

  CalculationBox.created() : super.created();

  void attachLeft(var e) {
    $['value-left-content'].children.clear();
    $['value-left-content'].children.add(e);
    e.parentElement = this;
  }

  void attachRight(var e) {
    $['value-right-content'].children.clear();
    $['value-right-content'].children.add(e);
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