import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('integer-literal')
class IntegerLiteral extends PolymerElement {
  program.Integer _model;

  set model(program.Integer m) {
    _model = m;
    value = m.value;
  }

  get model => _model;

  @published int value = 1;
  IntegerLiteral.created() : super.created();

  void attached() {
    $['literal-input'].onChange.listen((var e) {
      _model.value = value;
    });

    this.onClick.listen((var e) {
      globalController.setSelectedElem(e, this);
    });
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
