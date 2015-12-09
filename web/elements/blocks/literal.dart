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
  @published int value = 1;
  IntegerLiteral.created() : super.created();

  void attached() {
    $['literal-input'].onChange.listen(
        (var e) {
          model.value = value;
        }

    );

    this.onClick.listen(
      (var e) {
        globalController.setSelectedElem(e, this);
      }
    );
  }

  void select() {
    $['target'].style.border = 'solid';
  }

  void deselect() {
    $['target'].style.border = 'none';
  }
}