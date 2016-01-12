import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@CustomTag('outport-data')
class OutPortData extends PolymerElement {
  program.OutPortData _model;


  PolymerElement parentElement;

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


  void updateOutPortList() {
    $['name-menu-content'].children.clear();
    int counter = 0;
    var ports = globalController.onInitializeApp.find(program.AddOutPort);
    ports.forEach((program.AddOutPort p) {
      $['name-menu-content'].children.add(new html.Element.tag('paper-item')
        ..innerHtml = p.name
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });
  }

  void selectOutPort(String name) {
    print('selectOutPort($name) called (_model:$model)');
    int selected = -1;
    int counter  = 0;
    $['name-menu-content'].children.forEach((PaperItem p) {
      if (name == p.innerHtml) {
        selected = counter;
      }
      counter++;
    });

    if(selected < 0) {
      print('Invalid OutPort is selected in outport_data');
      selected = 0;
    }

    $['name-menu-content'].setAttribute('selected', selected.toString());

    updateAccessAlternatives();
  }



  void updateAccessAlternatives() {
    print('updateAccessAlternatives called (_model:$model)');
    $['menu-content'].children.clear();
    int counter = 0;
    var types = program.DataType.access_alternatives(_model.dataType.typename);
    types.forEach((List<String> alternative_pair) {
      $['menu-content'].children.add(new html.Element.tag('paper-item')
            ..innerHtml = alternative_pair[0] + ';'
            ..setAttribute('value', counter.toString())
      );
      counter++;
    });

    selectAccess(_model.accessSequence + ';');
  }

  void selectAccess(String name) {
    print('selectAccess($name) called (_model:$model)');
    int selected = -1;
    int counter = 0;
    $['menu-content'].children.forEach((PaperItem p) {
      print(p.innerHtml + '/' + name);
      var target_name = p.innerHtml;
      if (p.innerHtml.startsWith('.')) {
        target_name = p.innerHtml.substring(1);
      }
      if (name == target_name) {
        selected = counter;
      }
      counter++;
    });

    if (selected < 0) {
      print('Invalid OutPort Access is selected in outport_data');
      selected = 0;
    }

    $['menu-content'].setAttribute('selected', selected.toString());
  }


  void attached() {
    updateOutPortList();
    selectOutPort(_model.name);

    PaperDropdownMenu ndd = $['name-dropdown-menu'];
    ndd.on['core-select'].listen((var e) {
      if (e.detail != null) {
        if (!e.detail['isSelected']) {

        } else {
          String name_ = e.detail['item'].innerHtml;
          var pl = globalController.onInitializeApp.find(
              program.AddOutPort, name: name_);
          if (pl.length > 0) {
            program.AddOutPort outport = pl[0];
            _model.name = name_;
            if (_model.dataType != outport.dataType) {
              _model.dataType = outport.dataType;
              _model.accessSequence = '';

              updateAccessAlternatives();
            }
          }
        }
      }
    });
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
