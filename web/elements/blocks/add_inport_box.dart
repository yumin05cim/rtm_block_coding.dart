import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';
import '../../controller/controller.dart';
import 'add_port_box.dart';

@CustomTag('add-inport-box')
class AddInPortBox extends AddPortBox {

  static  AddInPortBox createBox(program.AddInPort m) {
    return new html.Element.tag('add-inport-box') as AddPortBox
      ..model = m;
  }

  PolymerElement parentElement;

  AddInPortBox.created() : super.created();


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
      print('Invalid InPort is selected in inport_data');
      selected = 0;
    }
    $['menu-content'].setAttribute('selected', selected.toString());
  }

  void onNameChange(String new_name) {
    String old_name = model.name;
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

    model.name = new_name;
    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void onTypeChange(String typename) {
    model.dataType = new program.DataType.fromTypeName(typename);

    String name_ = model.name;
    List<program.AccessInPort> ports = [];
    ports.addAll(globalController.onActivatedApp.find(program.AccessInPort, name: name_));
    ports.addAll(globalController.onExecuteApp.find(program.AccessInPort, name: name_));
    ports.addAll(globalController.onDeactivatedApp.find(program.AccessInPort, name: name_));
    ports.forEach((program.AccessInPort port) {
      port.dataType = model.dataType;
      port.accessSequence = '';
    });

    List<program.ReadInPort> ports2 = [];
    ports2.addAll(globalController.onActivatedApp.find(program.ReadInPort, name: name_));
    ports2.addAll(globalController.onExecuteApp.find(program.ReadInPort, name: name_));
    ports2.addAll(globalController.onDeactivatedApp.find(program.ReadInPort, name: name_));
    ports2.forEach((program.ReadInPort port) {
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
      if (e.detail != null) {
        if (e.detail['isSelected']) {
          model.dataType =
          new program.DataType.fromTypeName(e.detail['item'].innerHtml);
          onTypeChange(model.dataType.typename);
        }
      }
    });
  }

}

