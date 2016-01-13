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
    condition = m.condition;
    loop = m.loop;
  }

  get model => _model;

  @published program.Condition condition = null;
  @published program.StatementList loop;

  While.created() : super.created();

  void attached() {

    $['condition-input'].onChange.listen(
        (var e) {
      _model.condition = condition;
      globalController.refreshPanel();
    }
    );

    $['statement-input'].onChange.listen(
        (var e) {
      _model.loop = loop;
      globalController.refreshPanel();
    }
    );


    this.onClick.listen(
        (var e) {
      globalController.setSelectedElem(e, this);

      e.stopPropagation();

        }
    );
  }
/*
  void attachRight(var e) {
    $['statement-input'].children.clear();
    $['statement-input'].children.add(e);
    e.parentElement = this;
  }

  void attachLeft(var e) {
    $['condition-input'].children.clear();
    $['condition-input'].children.add(e);
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