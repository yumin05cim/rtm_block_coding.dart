import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'package:paper_elements/paper_dropdown.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';

@CustomTag('add-inport')
class AddInPort extends PolymerElement {
  program.AddInPort _model;

  set model(program.AddInPort m) {
    _model = m;
    port_name = m.name;
    port_type = m.dataType.typename;
  }

  get model => _model;

  @published String port_name = "defaultName";
  @published String port_type = "defaultType";
  AddInPort.created() : super.created();

  void attached() {
    $['name-input'].onChange.listen(
        (var e) {
          _model.name = port_name;
        }
    );

    var types = program.DataType.all_types;
      types.sort();
    types.forEach
    (
        (String typename) {
          $['menu-content'].children.add(
            new html.Element.tag('paper-item')
              ..innerHtml = typename
          );
        }
    );

    PaperDropdownMenu dd = $['dropdown-menu'];
    dd.on['core-select'].listen(
        (var e) {
          if (e.detail['isSelected']) {
            String typename = e.detail['item'].innerHtml;
            _model.dataType = new program.DataType.fromTypeName(typename);

          }
        }

    );

    $['title-area'].onClick.listen(
        (var e) {
          globalController.setSelectedElem(e, this);

        }
    );
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