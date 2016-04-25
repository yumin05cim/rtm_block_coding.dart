import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('while-statement')
class While extends PolymerElement {

  program.While _model;
  PolymerElement parentElement;

  set model(program.While m) {
    _model = m;
  }
  get model => _model;
  get loop => $['loop-content'];

  While.created() : super.created();

  void attached() {
/*
    $['condition-input'].onChange.listen(
        (var e) {
      _model.condition = condition;
      globalController.refreshPanel();
    }
    );

    $['loop-input'].onChange.listen(
        (var e) {
      _model.loop = loop;
      globalController.refreshPanel();
    }
    );
*/
  }

  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();
  }

  void attachCondition(var e) {
    $['condition-content'].children.clear();
    $['condition-content'].children.add(e);
    e.parentElement = this;
  }

/*  void attachLoop(var e) {
    $['loop-content'].children.clear();
    $['loop-content'].children.add(e);
    e.parentElement = this;
  }
*/

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

