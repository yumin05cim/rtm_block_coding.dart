import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';
import '../../controller/controller.dart';
import 'port_box.dart';

@CustomTag('inport-buffer-box')
class InPortBufferBox extends PortBox {

  program.InPortBuffer _model;

  static InPortBufferBox createBox(program.InPortBuffer m) {
    return new html.Element.tag('inport-buffer-box') as InPortBufferBox
      ..model = m;
  }

  set model(program.InPortBuffer m) {
    _model = m;
    name = m.name;
    access = m.accessSequence;

    int counter = 1;
  }

  get model => _model;

  @published String name = "name";
  @published String access = "";
  @observable String indexInputValue = '0';

  InPortBufferBox.created() : super.created();


  void updateInPortList() {
    $['name-menu-content'].children.clear();
    int counter = 0;
    var ports = globalController.onInitializeApp.find(program.AddInPort);
    ports.forEach((program.AddInPort p) {
      $['name-menu-content'].children.add(new html.Element.tag('paper-item')
        ..innerHtml = p.name
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });
  }

  void selectInPort(String name) {
    print('selectInPort($name) called (_model:$model)');
    int selected = -1;
    int counter  = 0;
    $['name-menu-content'].children.forEach((PaperItem p) {
      if (name == p.innerHtml) {
        selected = counter;
      }
      counter++;
    });

    if(selected < 0) {
      print('Invalid InPort is selected in inport_data');
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
      $['menu-content'].children.add(
          new html.Element.tag('paper-item')
            ..innerHtml = alternative_pair[0] + ' '
            ..setAttribute('value', counter.toString())
      );
      counter++;
    });

    selectAccess(_model.accessSequence + ' ');
  }

  void selectAccess(String accessName) {
    accessName = accessName.trim();
    name = accessName.trim();
    if (accessName.endsWith(']')) {
      name =
          name.substring(
              0, name.indexOf('['));
    }
    print('selectAccess($name) called (_model:${model.name})');
    print('accessSeq:' + model.accessSequence);
    var types = program.DataType.access_alternatives(_model.dataType.typename);
    int selected = -1;
    int counter  = 0;
    $['menu-content'].children.forEach((PaperItem p) {
          // print (p.innerHtml + '/' + name);
          var target_name = p.innerHtml;
          if (p.innerHtml.startsWith('.')) {
            target_name = p.innerHtml.substring(1).trim();
          }
      if(name.trim() == target_name) {
        selected = counter;

        String accessTypeName = program.DataType.access_alternative_type(_model.dataType.typename, name);
        if (program.DataType.isSeqType(accessTypeName)) {
          $['index-left'].style.display = 'block';
          $['index-input'].style.display = 'block';
          $['index-right'].style.display = 'block';
        } else {
          $['index-left'].style.display = 'none';
          $['index-input'].style.display = 'none';
          $['index-right'].style.display = 'none';
        }

        if (accessName.endsWith(']')) {
          indexInputValue = accessName.substring(accessName.indexOf('[')+1, accessName.indexOf(']'));
        } else {
          indexInputValue = ' ';
        }
        onInputIndex(null);
      }
      counter++;
    });

    if(selected < 0) {
      print('Invalid InPort Access is selected in inport_data');
      selected = 0;
    }

    $['menu-content'].setAttribute('selected', selected.toString());
  }

  void attached() {

    updateInPortList();
    selectInPort(_model.name);

    PaperDropdownMenu ndd = $['name-dropdown-menu'];
    ndd.on['core-select'].listen((var e) {
      if(e.detail != null) {
        if (!e.detail['isSelected']) {

        } else {
          String name_ = e.detail['item'].innerHtml;
          var pl = globalController.onInitializeApp.find(
              program.AddInPort, name: name_);
          if (pl.length > 0) {
            program.AddInPort inport = pl[0];
            _model.name = name_;
            if (_model.dataType.typename != inport.dataType.typename) {
              _model.dataType = inport.dataType;
              _model.accessSequence = '';

              updateAccessAlternatives();
            }
          }
        }
      }
    });

    PaperDropdownMenu dd = $['dropdown-menu'];
    dd.on['core-select'].listen((var e) {
      print('input_data: on-core-select:${model.name}');
      if(e.detail != null) {
        if (e.detail['isSelected']) {
          String accessName = e.detail['item'].innerHtml;

          if (accessName.startsWith('.')) {
            accessName = accessName.substring(1);
          }
          _model.accessSequence =
              accessName.substring(0, accessName.length - 1);

          String accessTypeName = program.DataType.access_alternative_type(_model.dataType.typename, accessName);
          if(program.DataType.isSeqType(accessTypeName)) {
            $['index-left'].style.display = 'block';
            $['index-input'].style.display = 'block';
            $['index-right'].style.display = 'block';
          } else {
            $['index-left'].style.display = 'none';
            $['index-input'].style.display = 'none';
            $['index-right'].style.display = 'none';
          }
          onInputIndex(null);
        }
      }
    });

    $['index-input'].onChange.listen((var e) {
      onInputIndex(e);
    });

  }

  void onInputIndex(var e) {
    print('index:$indexInputValue');
    if (_model.accessSequence.endsWith(']')) {
      _model.accessSequence =
          _model.accessSequence.substring(
              0, _model.accessSequence.indexOf('['));
    }
    if (indexInputValue.trim().length > 0) {
      _model.accessSequence = _model.accessSequence + '[' + indexInputValue + ']';
    }
  }

}
