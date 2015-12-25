import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('read-inport')
class ReadInPort extends PolymerElement {
  program.ReadInPort _model;

  set model(program.ReadInPort m) {
    _model = m;
    port_name = m.name;
    port_type = m.dataType.typename;
  }

  get model => _model;

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

  void select() {
    $['title-area'].style.border = 'ridge';
    $['title-area'].style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $['title-area'].style.border = 'none';
  }

  bool is_container() {
    return true;
  }

  void add(var element) {
    $['target'].children.add(element);
  }

  void clear(var element) {
    $['target'].children.clear();
  }
}