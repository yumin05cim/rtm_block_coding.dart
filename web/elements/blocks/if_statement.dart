import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('if-statement')
class If extends PolymerElement {

  program.If _model;

  PolymerElement parentElement;

  set model(program.If m) {
    _model = m;
    ///condition = m.condition;
    //yes = m.yes;
    //no = m.no;
  }

  get model => _model;

  get yes => $['yes-content'];
  /// get no => $['no-content'];


  /*
  @published program.Condition condition = null;
  @published program.StatementList yes;
  @published program.StatementList no;
  */

  If.created() : super.created();

  void attached() {

/*
    $['true-input'].onChange.listen(
        (var e) {
          //_model.yes = yes;
          globalController.refreshPanel();
    }
    );

    $['false-input'].onChange.listen(
        (var e) {
          //_model.no = no;
          globalController.refreshPanel();
      }
    );
*/

    this.onClick.listen(
      (var e) {
        globalController.setSelectedElem(e, this);

        e.stopPropagation();
      }
    );
  }

  void attachCondition(var e) {
    $['condition-content'].children.clear();
    $['condition-content'].children.add(e);
    e.parentElement = this;
  }

  void attachTrue(var e) {
    $['yes-content'].children.clear();
    $['yes-content'].children.add(e);
    e.parentElement = this;
  }

  /*
  void attachFalse(var e) {
    $['no-content'].children.clear();
    $['no-content'].children.add(e);
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