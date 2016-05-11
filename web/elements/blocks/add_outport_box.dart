import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';
import '../../controller/controller.dart';
import 'add_port_box.dart';

@CustomTag('add-outport-box')
class AddOutPortBox extends AddPortBox {

  static  AddOutPortBox createBox(program.AddOutPort m) {
    return new html.Element.tag('add-outport-box') as AddOutPortBox
      ..model = m;
  }

  AddOutPortBox.created() : super.created();


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
    String old_name = model.name;
    List<program.AccessOutPort> ports = [];
    ports.addAll(globalController.onActivatedApp.find(program.AccessOutPort, name: old_name));
    ports.addAll(globalController.onExecuteApp.find(program.AccessOutPort, name: old_name));
    ports.addAll(globalController.onDeactivatedApp.find(program.AccessOutPort, name: old_name));
    ports.forEach((program.AccessOutPort port) {
      port.name = new_name;
    });

    List<program.WriteOutPort> ports2 = [];
    ports2.addAll(globalController.onActivatedApp.find(program.WriteOutPort, name: old_name));
    ports2.addAll(globalController.onExecuteApp.find(program.WriteOutPort, name: old_name));
    ports2.addAll(globalController.onDeactivatedApp.find(program.WriteOutPort, name: old_name));
    ports2.forEach((program.WriteOutPort port) {
      port.name = new_name;
    });

    model.name = new_name;
    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void onTypeChange(String typename) {
    model.dataType = new program.DataType.fromTypeName(typename);

    String name_ = model.name;
    List<program.AccessOutPort> ports = [];
    ports.addAll(globalController.onActivatedApp.find(program.AccessOutPort, name: name_));
    ports.addAll(globalController.onExecuteApp.find(program.AccessOutPort, name: name_));
    ports.addAll(globalController.onDeactivatedApp.find(program.AccessOutPort, name: name_));
    ports.forEach((program.AccessOutPort port) {
      port.dataType = model.dataType;
      port.accessSequence = '';
    });

    List<program.WriteOutPort> ports2 = [];
    ports2.addAll(globalController.onActivatedApp.find(program.WriteOutPort, name: name_));
    ports2.addAll(globalController.onExecuteApp.find(program.WriteOutPort, name: name_));
    ports2.addAll(globalController.onDeactivatedApp.find(program.WriteOutPort, name: name_));
    ports2.forEach((program.WriteOutPort port) {
      port.dataType = model.dataType;
      //port.accessSequence = '';
    });

    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void attached() {
    $['name-input'].onChange.listen((var e) {
      // When name changed.
      onNameChange(port_name);
    });

    var types = program.DataType.all_types;
    types.sort();
    int counter = 0;
    types.forEach((String typename) {
      $['menu-content'].children.add(new html.Element.tag('paper-item')
            ..innerHtml = typename
            ..setAttribute('value', counter.toString())
      );
      counter++;
    });

    selectType(model.dataType.typename);
    PaperDropdownMenu dd = $['dropdown-menu'];
    dd.on['core-select'].listen((var e) {
      if(e.detail != null) {
        if (e.detail['isSelected']) {
          model.dataType =
          new program.DataType.fromTypeName(e.detail['item'].innerHtml);
          onTypeChange(model.dataType.typename);
        }
      }
    });
  }

}

