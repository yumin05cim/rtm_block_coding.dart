import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('if-statement')
class If extends PolymerElement {

  program.If _model;

  set model(program.If m) {
    _model = m;
    condition = m.condition;
    yes = m.yes;
    no = m.no;
  }

  get model => _model;

  @published program.Condition condition = null;
  @published program.StatementList yes;
  @published program.StatementList no;

  If.created() : super.created();

  void attached() {
    $['condition-input'].onChange.listen(
        (var e) {
//          _model.name = name;

          globalController.refreshPanel();
        }
    );

    $['true-input'].onChange.listen(
        (var e) {
//          _model.accessSequence = access;
      globalController.refreshPanel();
    }
    );

    $['false-input'].onChange.listen(
        (var e) {
//          _model.accessSequence = access;
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
    $['target'].style.border = 'none';
  }

  bool is_container() {
    return false;
  }
}