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


    $['title-area'].onClick.listen(
        (var e) {
          globalController.setSelectedElem(e, this);

        }
    );
  }

  void select() {
    $['title-area'].style.borderTop = 'ridge';
    $['title-area'].style.borderLeft = 'ridge';
    $['title-area'].style.borderRight = 'ridge';
    $['title-area'].style.borderColor = '#FF9F1C';
    $['body-area'].style.borderBottom = 'ridge';
    $['body-area'].style.borderLeft = 'ridge';
    $['body-area'].style.borderRight = 'ridge';
    $['body-area'].style.borderColor = '#FF9F1C';
  }

  void deselect() {

    $['title-area'].style.borderTop = '1px solid';
    $['title-area'].style.borderLeft = '1px solid';
    $['title-area'].style.borderRight = '1px solid';
    $['title-area'].style.borderColor = '#B6B6B6';
    $['body-area'].style.borderBottom = '1px solid';
    $['body-area'].style.borderLeft = '1px solid';
    $['body-area'].style.borderRight = '1px solid';
    $['body-area'].style.borderColor = '#B6B6B6';

//    $['title-area'].style.border = '1px solid #B6B6B6';
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