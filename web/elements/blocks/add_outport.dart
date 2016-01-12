import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

import 'package:paper_elements/paper_dropdown_menu.dart';

@CustomTag('add-outport')
class AddOutPort extends PolymerElement {
  program.AddOutPort _model;

  PolymerElement parentElement;

  set model(program.AddOutPort m) {
    _model = m;
    port_name = m.name;
    port_type = m.dataType.typename;
  }

  get model => _model;

  @published String port_name = "defaultName";
  @published String port_type = "defaultType";
  AddOutPort.created() : super.created();


  void selectType(String name) {
    int selected = -1;
    int counter  = 0;
    $['menu-content'].children.forEach(
        (PaperItem p) {
      if(name == p.innerHtml) {
        selected = counter;
      }
      counter++;
    }
    );

    if(selected < 0) {
      print('Invalid OutPort is selected in inport_data');
      selected = 0;
    }
    $['menu-content'].setAttribute('selected', selected.toString());
  }


  void onNameChange(String new_name) {
    String old_name = _model.name;
    List<program.OutPortData> ports = [];
    ports.addAll(globalController.onActivatedApp.find(program.OutPortData, name: old_name));
    ports.addAll(globalController.onExecuteApp.find(program.OutPortData, name: old_name));
    ports.addAll(globalController.onDeactivatedApp.find(program.OutPortData, name: old_name));
    ports.forEach((program.OutPortData port) {
      port.name = new_name;
    });


    List<program.OutPortWrite> ports2 = [];
    ports2.addAll(globalController.onActivatedApp.find(program.OutPortWrite, name: old_name));
    ports2.addAll(globalController.onExecuteApp.find(program.OutPortWrite, name: old_name));
    ports2.addAll(globalController.onDeactivatedApp.find(program.OutPortWrite, name: old_name));
    ports2.forEach((program.OutPortWrite port) {
      port.name = new_name;
    });

    _model.name = new_name;
    globalController.refreshAllPanel();

  }


  void onTypeChange(String typename) {
    _model.dataType = new program.DataType.fromTypeName(typename);

    String name_ = _model.name;
    List<program.OutPortData> ports = [];
    ports.addAll(globalController.onActivatedApp.find(program.OutPortData, name: name_));
    ports.addAll(globalController.onExecuteApp.find(program.OutPortData, name: name_));
    ports.addAll(globalController.onDeactivatedApp.find(program.OutPortData, name: name_));
    ports.forEach((program.OutPortData port) {
      port.dataType = _model.dataType;
      port.accessSequence = '';
    });

    List<program.OutPortWrite> ports2 = [];
    ports2.addAll(globalController.onActivatedApp.find(program.OutPortWrite, name: name_));
    ports2.addAll(globalController.onExecuteApp.find(program.OutPortWrite, name: name_));
    ports2.addAll(globalController.onDeactivatedApp.find(program.OutPortWrite, name: name_));
    ports2.forEach((program.OutPortWrite port) {
      port.dataType = _model.dataType;
      port.accessSequence = '';
    });

    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void attached() {
    $['name-input'].onChange.listen((var e) {
      onNameChange(port_name);
    });

    var types = program.DataType.all_types;
    types.sort();
    int counter = 0;
    types.forEach((String typename) {
      $['menu-content'].children.add(
          new html.Element.tag('paper-item')
            ..innerHtml = typename
            ..setAttribute('value', counter.toString())
      );
    });

    selectType(_model.dataType.typename);
    PaperDropdownMenu dd = $['dropdown-menu'];
    dd.on['core-select'].listen((var e) {
      if(e.detail != null) {
        if (e.detail['isSelected']) {
          _model.dataType =
          new program.DataType.fromTypeName(e.detail['item'].innerHtml);
          onTypeChange(typename);
        }
      }
    });

    $['title-area'].onClick.listen((var e) {
      globalController.setSelectedElem(e, this);
    });
  }

  void select() {
    $['title-area'].style.border = 'ridge';
    $['title-area'].style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $['title-area'].style.border = '1px solid #B6B6B6';
  }

  bool is_container() {
    return false;
  }

}