import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import '../../controller/controller.dart';

@CustomTag('assign-variable-box')
class AssignVariableBox extends PolymerElement {

  program.Assign _model;

  PolymerElement parentElement;

  set model(program.Assign m) {
    _model = m;
    name = _model.left.name;
  }

  get model => _model;

  @published String name = "defaultName";

  AssignVariableBox.created() : super.created();

  void updateNameList() {
    $['name-menu-content'].children.clear();
    int counter = 0;
    var ports = globalController.onInitializeApp.find(program.AddOutPort);
    if(ports == null) ports = [];
    ports.forEach((program.AddOutPort p) {
      $['name-menu-content'].children.add(new html.Element.tag('paper-item')
        ..innerHtml = p.name
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });
    var variables = globalController.onInitializeApp.find(program.DeclareVariable);
    if(variables == null)variables = [];
    variables.forEach((program.DeclareVariable p) {
      $['name-menu-content'].children.add(new html.Element.tag('paper-item')
        ..innerHtml = p.name
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });
  }

  void selectName(String name) {
    print('selectName($name) called (_model:$model)');
    int selected = -1;
    int counter  = 0;
    $['name-menu-content'].children.forEach((PaperItem p) {
      if (name == p.innerHtml) {
        selected = counter;
      }
      counter++;
    });

    if(selected < 0) {
      print('Invalid Name is selected in assing_block');
      selected = 0;
    }

    $['name-menu-content'].setAttribute('selected', selected.toString());

    updateAccessAlternatives();
  }


  void attached() {
    /*
    updateNameList();
    selectName(_model.left.name);

    PaperDropdownMenu ndd = $['name-dropdown-menu'];
    ndd.on['core-select'].listen((var e) {
      if (e.detail != null) {
        if (!e.detail['isSelected']) {

        } else {
          String name_ = e.detail['item'].innerHtml;
          // Search OutPort
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
            return;
          }

          var vl = globalController.onInitializeApp.find(
              program.DeclareVariable, name: name_);
          if (vl.length > 0) {
            program.DeclareVariable v = vl[0];
            _model.name = name_;
            if (_model.dataType != v.dataType) {
              _model.dataType = v.dataType;
              _model.accessSequence = '';

              updateAccessAlternatives();
            }
            return;
          }

        }
      }
    });

    $['menu-content'].setAttribute('selected', selected.toString());
    */

  }

  void updateAccessAlternatives() {
    print('updateAccessAlternatives called (_model:$model)');
    $['menu-content'].children.clear();
    int counter = 0;

    var types = program.DataType.access_alternatives(_model.left.dataType.typename);
    types.forEach((List<String> alternative_pair) {
      $['menu-content'].children.add(new html.Element.tag('paper-item')
        ..innerHtml = alternative_pair[0] + ';'
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });

    if(_model.left is program.OutPortBuffer) {
      selectAccess(_model.left.accessSequence + ';');
    }
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

  void attachRightTarget(var element) {
    $['right-content'].children.clear();
    $['right-content'].children.add(element);
    element.parentElement = this;
  }

  void attachLeftTarget(var element) {
    $['left-content'].children.clear();
    $['left-content'].children.add(element);
    element.parentElement = this;
  }

  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();
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
