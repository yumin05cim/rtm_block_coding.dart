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

    $['type-input'].onChange.listen(
        (var e) {
      _model.dataType = new program.DataType.fromTypeName(port_type);
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
    $['target'].style.border = 'solid';
  }

  void deselect() {
    $['target'].style.border = 'none';
  }

  bool is_container() {
    return false;
  }
}