import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';
import '../../controller/controller.dart';

@CustomTag('write-outport-box')
class WriteOutPortBox extends PolymerElement {

  program.WriteOutPort _model;

  PolymerElement parentElement;

  set model(program.WriteOutPort m) {
    _model = m;
    port_name = m.name;
    port_type = m.dataType.typename;
  }

  get model => _model;

  @published String port_name = "name";
  @published String port_type = "type";

  WriteOutPortBox.created() : super.created();


  void updateOutPortList() {
    $['menu-content'].children.clear();

    int counter = 0;
    var ports = globalController.onInitializeApp.find(program.AddOutPort);
    ports.forEach((program.AddOutPort p) {
      $['menu-content'].children.add(
          new html.Element.tag('paper-item')
            ..innerHtml = p.name
            ..setAttribute('value', counter.toString())
      );
      counter++;
    }
    );
  }

  void selectOutPort(String name) {
    int selected = -1;
    int counter  = 0;
    $['menu-content'].children.forEach((PaperItem p) {
      if(name == p.innerHtml) {
        selected = counter;
      }
      counter++;
    });

    if(selected < 0) {
      print('Invalid OutPort is selected in outport_data');
      selected = 0;
    }

    $['menu-content'].setAttribute('selected', selected.toString());
  }

  void attached() {
    updateOutPortList();
    selectOutPort(_model.name);

    PaperDropdownMenu ndd = $['dropdown-menu'];
    ndd.on['core-select'].listen((var e) {
      if (e.detail != null) {
        if (!e.detail['isSelected']) {

        } else {
          String name_ = e.detail['item'].innerHtml;
          var pl = globalController.onInitializeApp.find(
              program.AddOutPort, name: name_);
          if (pl.length > 0) {
            program.AddOutPort inport = pl[0];
            _model.name = name_;
            if (_model.dataType != inport.dataType) {
              _model.dataType = inport.dataType;
            }
          }
        }
      }
    });
  }

  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();
  }

  void select() {
    $['target'].style.border = 'ridge';
    ($['target'] as html.HtmlElement).style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $['target'].style.border = '1px solid #B6B6B6';
  }

  bool is_container() {
    return false;
  }
}