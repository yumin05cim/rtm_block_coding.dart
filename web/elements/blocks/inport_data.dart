import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

import 'package:paper_elements/paper_dropdown.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';


@CustomTag('inport-data')
class InPortData extends PolymerElement {

  program.InPortDataAccess _model;

  set model(program.InPortDataAccess m) {
    _model = m;
    name = m.name;
    access = m.accessSequence;

    int counter = 1;
    print('set model');

    /*
    var types = program.DataType.access_alternatives(m.dataType.typename);
    print('types');
    print(types);


    types.forEach(
        (List<String> alternative_pair) {
          print (alternative_pair);
          $['menu-content'].children.add(
              new html.Element.tag('paper-item')
                ..innerHtml = counter.toString()
                ..setAttribute('value', counter.toString())
          );
          counter++;
        }
    );
    */

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

    int counter = 1;
    var types = program.DataType.access_alternatives(_model.dataType.typename);
    types.forEach(
        (List<String> alternative_pair) {
      $['menu-content'].children.add(
          new html.Element.tag('paper-item')
            ..innerHtml = alternative_pair[0] + '(' + alternative_pair[1] + ')'
            ..setAttribute('value', counter.toString())
      );
      counter++;
    }
    );


    print('attached');
    PaperDropdownMenu dd = $['dropdown-menu'];
    $['menu-content'].setAttribute('selected', '1');
    dd.on['core-select'].listen(
        (var e) {
      if (e.detail['isSelected']) {
        String accessName = e.detail['item'].innerHtml;

        _model.accessSequence = accessName.substring(1, accessName.indexOf('('));
        print(accessName);
        //globalController.refreshPanel();
        //_model.dataType = new program.DataType.fromTypeName(typename);

      }
    }

    );




    this.onClick.listen(
      (var e) {
        globalController.setSelectedElem(e, this);
      }
    );
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