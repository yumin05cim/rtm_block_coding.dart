import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('set-variable')
class SetVariable extends PolymerElement {
  program.SetValue _model;

  PolymerElement parentElement;

  set model(program.SetValue m) {
    _model = m;
    name = _model.left.name;
  }

  get model => _model;

  @published String name = "defaultName";

  SetVariable.created() : super.created();

  void attached() {
    $['variable-name-input'].onChange.listen(
        (var e) {
          _model.left.name = name;
        }
    );

    $['title-area'].onClick.listen(
        (var e) {
          globalController.setSelectedElem(e, this);
          e.stopPropagation();
        }
    );
  }

  void attachTarget(var element) {
    $['target'].children.clear();
    $['target'].children.add(element);
    element.parentElement = this;
  }

  void select() {
    $['container'].style.border = 'ridge';
    ($['container'] as html.HtmlElement).style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $['container'].style.border = '1px solid #B6B6B6';
  }

  bool is_container() {
    return false;
  }
}
