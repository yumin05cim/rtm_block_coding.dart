import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('equals-element')
class EqualsElement extends PolymerElement {

  program.Equals _model;

  PolymerElement parentElement;

  String leftLabel;
  String rightLabel;

  set model(program.Equals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  EqualsElement.created() : super.created();

  void attached() {
    this.onClick.listen((var e) {
      globalController.setSelectedElem(e, this);

      e.stopPropagation();
    });
  }

  void attachRight(var e) {
    $['right-content'].children.clear();
    $['right-content'].children.add(e);
    e.parentElement = this;
  }

  void attachLeft(var e) {
    $['left-content'].children.clear();
    $['left-content'].children.add(e);
    e.parentElement = this;
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



@CustomTag('notequals-element')
class NotEqualsElement extends PolymerElement {

  program.NotEquals _model;

  PolymerElement parentElement;

  String leftLabel;
  String rightLabel;

  set model(program.Equals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  NotEqualsElement.created() : super.created();

  void attached() {
    this.onClick.listen((var e) {
      globalController.setSelectedElem(e, this);

      e.stopPropagation();
    });
  }

  void attachRight(var e) {
    $['right-content'].children.clear();
    $['right-content'].children.add(e);
    e.parentElement = this;
  }

  void attachLeft(var e) {
    $['left-content'].children.clear();
    $['left-content'].children.add(e);
    e.parentElement = this;
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