import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation.dart';

@CustomTag('calc-multiplication')
class Multiplication extends Calculation {

  program.Multiply _model;

  PolymerElement parentElement;

  set model(program.Multiply m) {
    _model = m;
    //value_a = m.a;
    //value_b = m.b;
  }

  get model => _model;

  Multiplication.created() : super.created();
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
/*
  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();

  }

  void attachRight(var e) {
    $['multi-value-b-content'].children.clear();
    $['multi-value-b-content'].children.add(e);
    e.parentElement = this;
  }

  void attachLeft(var e) {
    $['multi-value-a-content'].children.clear();
    $['multi-value-a-content'].children.add(e);
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
  }*/
}