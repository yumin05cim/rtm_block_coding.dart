import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('integer-input')
class IntegerInput extends PolymerElement {

  program.Integer _model;

  PolymerElement parentElement;

  set model(program.Integer m) {
    _model = m;
    int_value = m.value;
  }

  get model => _model;

  @published program.Integer int_value;

  IntegerInput.created() : super.created();

  void attached() {

    $['int-value-input'].onChange.listen(
        (var e) {
      _model.value = int_value;

      globalController.refreshPanel();
    }
    );

    this.onClick.listen(
        (var e) {
      globalController.setSelectedElem(e, this);
    }
    );
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