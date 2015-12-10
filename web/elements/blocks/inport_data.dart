import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('inport-data')
class InPortData extends PolymerElement {

  program.InPortDataAccess _model;

  set model(program.InPortDataAccess m) {
    _model = m;
    name = m.name;
    access = m.accessSequence;
  }

  get model => _model;

  @published String name = "name";
  @published String access = "";
  InPortData.created() : super.created();

  void attached() {
    $['name-input'].onChange.listen(
        (var e) {
          _model.name = name;

          globalController.refreshPanel();
        }
    );

    $['access-input'].onChange.listen(
        (var e) {
          _model.accessSequence = access;
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