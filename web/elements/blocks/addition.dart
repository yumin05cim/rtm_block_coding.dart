import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation.dart';

@CustomTag('calc-addition')
class Addition extends Calculation {

  program.Add _model;

  PolymerElement parentElement;

  set model(program.Add m) {
    _model = m;
    //value_a = m.a;
    //value_b = m.b;
  }

  get model => _model;

  Addition.created() : super.created();
/*
  void attached() {
    $['value1-input'].onChange.listen(
        (var e) {
      _model.a = value_a;

      globalController.refreshPanel();
    }
    );
    $['value2-input'].onChange.listen(
        (var e) {
      _model.b = value_b;

      globalController.refreshPanel();
    }
    );

  }*/

/*  void attachRight(var e) {
    $['add-value-b-content'].children.clear();
    $['add-value-b-content'].children.add(e);
    e.parentElement = this;
  }

  void attachLeft(var e) {
    $['add-value-a-content'].children.clear();
    $['add-value-a-content'].children.add(e);
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
  }*/

}