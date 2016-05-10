import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';
import '../../controller/controller.dart';
import 'variable_box.dart';

@CustomTag('refer-variable-box')
class ReferVariableBox extends VariableBox {

  program.ReferVariable _model;

  static ReferVariableBox createBox(program.ReferVariable m) {
    return new html.Element.tag('refer-variable-box') as ReferVariableBox
      ..model = m;
  }

  set model(program.ReferVariable m) {
    _model = m;
  }

  get model => _model;

  ReferVariableBox.created() : super.created();

  void updateNameList() {
    $['name-menu-content'].children.clear();
    int counter = 0;
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
    int selected = -1;
    int counter = 0;
    $['name-menu-content'].children.forEach((PaperItem p) {
      if (name == p.innerHtml) {
        selected = counter;
      }
      counter++;
    });

    if (selected < 0) {
      print('Invalid Name is selected in assing_block');
      selected = 0;
    }
    $['name-menu-content'].setAttribute('selected', selected.toString());
  }

  void attached() {
    updateNameList();
    selectName(_model.name);

    PaperDropdownMenu ndd = $['name-dropdown-menu'];
    ndd.on['core-select'].listen((var e) {
      if (e.detail != null) {
        if (!e.detail['isSelected']) {

        } else {
          String name_ = e.detail['item'].innerHtml;
          var pl = globalController.onInitializeApp.find(
              program.DeclareVariable, name: name_);
          if (pl.length > 0) {
            program.DeclareVariable v = pl[0];
            _model.name = name_;
            if (_model.dataType != v.dataType) {
              _model.dataType = v.dataType;
            }
          }
        }
      }
    });
  }

}
