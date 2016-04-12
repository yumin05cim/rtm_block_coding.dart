import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'calculation.dart';

@CustomTag('calc-subtraction')
class Subtraction extends Calculation {

  program.Subtract _model;

  PolymerElement parentElement;

  set model(program.Subtract m) {
    _model = m;
    //value_a = m.a;
    //value_b = m.b;
  }

  get model => _model;

  //@published program.Block value_a;
  //@published program.Block value_b;
  Subtraction.created() : super.created();

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
    $['sub-value-b-content'].children.clear();
    $['sub-value-b-content'].children.add(e);
    e.parentElement = this;
  }

  void attachLeft(var e) {
    $['sub-value-a-content'].children.clear();
    $['sub-value-a-content'].children.add(e);
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