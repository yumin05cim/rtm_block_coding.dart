import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('outport-data')
class OutPortData extends PolymerElement {
  program.OutPortData _model;

  set model(program.OutPortData m) {
    _model = m;
    port_name = _model.name;
    port_type = _model.dataType.typename;
    data_member = _model.accessSequence;
  }

  get model => _model;

  @published String port_name = "defaultName";
  @published String port_type = "defaultType";
  @published String data_member = "data";

  OutPortData.created() : super.created();

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

    $['member-input'].onChange.listen(
        (var e) {
      _model.accessSequence = data_member;
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
