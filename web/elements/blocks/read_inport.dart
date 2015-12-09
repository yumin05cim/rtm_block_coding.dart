import 'dart:html' as html;

import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'package:rtm_block_coding/application.dart' as program;

@CustomTag('read-inport')
class ReadInPort extends PolymerElement {
  program.ReadInPort _model;

  set model(program.ReadInPort m) {
    _model = m;
    port_name = m.name;
    port_type = m.dataType.typename;
  }

  @published String port_name = "defaultName";
  @published String port_type = "defaultType";
  ReadInPort.created() : super.created();

  void attached() {
    $['name-input'].onChange.listen(
        (var e) {
          _model.name = port_name;
        }
    );

    $['type-input'].onChange.listen(
        (var e) {
      _model.dataType = new program.DataType.fromTypeName(port_type);
    }
    );

    $['title-area'].onClick.listen(
        (var e) {
          globalController.setSelectedElem(e, this);

        }
    );
  }

  void attachTarget(var element) {
    $['target'].children.clear();
    $['target'].children.add(element);
  }

  void select() {
    this.style.border = 'solid';
  }

  void deselect() {
    this.style.border = 'none';
  }
}