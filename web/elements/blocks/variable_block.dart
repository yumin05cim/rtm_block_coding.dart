import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('variable-block')
class VariableBlock extends PolymerElement {
  program.Variable _model;
  get model => _model;

  PolymerElement parentElement;

  set model(program.Variable m) {
    _model = m;
  }

  VariableBlock.created() : super.created();

  void updateNameList() {
    $['name-menu-content'].children.clear();
    int counter = 0;
    var variables = globalController.onInitializeApp.find(program.DeclareVariable);
    if(variables == null)variables = [];
    variables.forEach((program.DeclareVariable p) {
      $['name-menu-content'].children.add(new html.Element.tag('paper-item')
        ..innerHtml = p.name
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });
  }

  void selectName(String name) {
    int selected = -1;
    int counter = 0;
    $['name-menu-content'].children.forEach((PaperItem p) {
      if (name == p.innerHtml) {
        selected = counter;
      }
      counter++;
    });

    if (selected < 0) {
      print('Invalid Name is selected in assing_block');
      selected = 0;
    }
    $['name-menu-content'].setAttribute('selected', selected.toString());
  }

  void attached() {
    updateNameList();
    selectName(_model.name);
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
  }
}