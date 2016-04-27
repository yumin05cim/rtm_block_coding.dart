import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';

@CustomTag('add-variable-box')
class AddVariableBox extends PolymerElement {

  program.DeclareVariable _model;

  PolymerElement parentElement;

  set model(program.AddInPort m) {
    _model = m;
    name = m.name;
    type = m.dataType.typename;
  }

  get model => _model;

  @published String name = "defaultName";
  @published String type = "defaultType";
   AddVariableBox.created() : super.created();

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
      print('Invalid Variable is selected in data');
      selected = 0;
    }

    $['menu-content'].setAttribute('selected', selected.toString());

  }

  void onNameChange(String new_name) {
    String old_name = _model.name;
    List<program.AccessInPort> ports = [];
    ports.addAll(globalController.onActivatedApp.find(program.AccessInPort, name: old_name));
    ports.addAll(globalController.onExecuteApp.find(program.AccessInPort, name: old_name));
    ports.addAll(globalController.onDeactivatedApp.find(program.AccessInPort, name: old_name));
    ports.forEach((program.AccessInPort port) {
      port.name = new_name;
    });

    List<program.ReadInPort> ports2 = [];
    ports2.addAll(globalController.onActivatedApp.find(program.ReadInPort, name: old_name));
    ports2.addAll(globalController.onExecuteApp.find(program.ReadInPort, name: old_name));
    ports2.addAll(globalController.onDeactivatedApp.find(program.ReadInPort, name: old_name));
    ports2.forEach((program.ReadInPort port) {
      port.name = new_name;
    });

    _model.name = new_name;
    globalController.refreshAllPanel();
  }

  void onTypeChange(String typename) {
    _model.dataType = new program.DataType.fromTypeName(typename);

    String name_ = _model.name;
    List<program.AccessInPort> ports = [];
    ports.addAll(globalController.onActivatedApp.find(program.AccessInPort, name: name_));
    ports.addAll(globalController.onExecuteApp.find(program.AccessInPort, name: name_));
    ports.addAll(globalController.onDeactivatedApp.find(program.AccessInPort, name: name_));
    ports.forEach((program.AccessInPort port) {
      port.dataType = _model.dataType;
      port.accessSequence = '';
    });

    List<program.ReadInPort> ports2 = [];
    ports2.addAll(globalController.onActivatedApp.find(program.ReadInPort, name: name_));
    ports2.addAll(globalController.onExecuteApp.find(program.ReadInPort, name: name_));
    ports2.addAll(globalController.onDeactivatedApp.find(program.ReadInPort, name: name_));
    ports2.forEach((program.ReadInPort port) {
      port.dataType = _model.dataType;
      //port.accessSequence = '';
    });

    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void attached() {
    $['name-input'].onChange.listen((var e) {
      // When name changed.
      onNameChange(name);
    });

    var types = program.DataType.PrimitiveTypes;
    types.sort();
    int counter = 0;
    types.forEach((String typename) {
      $['menu-content'].children.add(new html.Element.tag('paper-item')
            ..innerHtml = typename
            ..setAttribute('value', counter.toString())
      );
      counter++;
    });

    selectType(_model.dataType.typename);
    PaperDropdownMenu dd = $['dropdown-menu'];
    dd.on['core-select'].listen((var e) {
          if (e.detail != null) {
            if (e.detail['isSelected']) {
              String typename = e.detail['item'].innerHtml;
              onTypeChange(typename);
            }
          }
        }
    );

  }

  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();
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