import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('write-outport')
class WriteOutPort extends PolymerElement {

  program.OutPortWrite _model;

  set model(program.OutPortWrite m) {
    _model = m;
    port_name = m.name;
    port_type = m.dataType.typename;
  }

  get model => _model;

  @published String port_name = "name";
  @published String port_type = "type";

  WriteOutPort.created() : super.created();

  void attached() {
    $['name-input'].onChange.listen(
        (var e) {
      _model.name = port_name;

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