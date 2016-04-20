import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';


@CustomTag('else-statement')
class Else extends PolymerElement {

  program.Else _model;

  PolymerElement parentElement;

  set model(program.Else m) {
    _model = m;

    ///condition = m.condition;
    //yes = m.yes;
    //no = m.no;
  }

  get model => _model;

  get contents => $['content-content'];

  /// get no => $['no-content'];

  /*
  @published program.Condition condition = null;
  @published program.StatementList yes;
  @published program.StatementList no;
  */

  Else.created() : super.created();

  void attached() {
  }

  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();
  }

  void attachTrue(var e) {
    $['no-content'].children.clear();
    $['no-content'].children.add(e);
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

