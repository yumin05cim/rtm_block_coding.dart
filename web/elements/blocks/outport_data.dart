import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';
import '../../controller/controller.dart';


@CustomTag('outport-data')
class OutPortData extends PolymerElement {
  program.OutPortBuffer _model;

  PolymerElement parentElement;

  get model => _model;

  //@published String port_name = "defaultName";
  //@published String port_type = "defaultType";
  //@published String data_member = "data";
  @observable String indexInputValue = '0';

  set model(program.OutPortBuffer m) {
    _model = m;
    //port_name = _model.name;
    //port_type = _model.dataType.typename;
    //data_member = _model.accessSequence;
  }

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
            ..innerHtml = alternative_pair[0] + ' '
            ..setAttribute('value', counter.toString())
      );
      counter++;
    });

    selectAccess(_model.accessSequence + ' ');
  }

  void selectAccess(String accessName) {
    accessName = accessName.trim();
    var name = accessName.trim();
    if (accessName.endsWith(']')) {
      name =
          name.substring(
              0, name.indexOf('['));
    }
    print('selectAccess($name) called (_model:${model.name})');
    print('accessSeq:' + model.accessSequence);

    int selected = -1;
    int counter = 0;
    $['menu-content'].children.forEach((PaperItem p) {
      var target_name = p.innerHtml;
      if (p.innerHtml.startsWith('.')) {
        target_name = p.innerHtml.substring(1).trim();
      }
      if (name.trim() == target_name) {
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

        print('indexInptValue=${indexInputValue}');
        onInputIndex(null);
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
            if (_model.dataType.typename != outport.dataType.typename) {
              _model.dataType = outport.dataType;
              _model.accessSequence = '';

              updateAccessAlternatives();
            }
          }
        }
      }
    });

    PaperDropdownMenu dd = $['dropdown-menu'];
    dd.on['core-select'].listen((var e) {
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

  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();
  }

  void onInputIndex(var e) {

    print('index:$indexInputValue');
    if (_model.accessSequence.endsWith(']')) {
      _model.accessSequence =
          _model.accessSequence.substring(
              0, _model.accessSequence.indexOf('['));
    }
    String accessTypeName = program.DataType.access_alternative_type(_model.dataType.typename, _model.accessSequence);

    if(program.DataType.isSeqType(accessTypeName)) {

      if (indexInputValue
          .trim()
          .length > 0) {
        _model.accessSequence =
            _model.accessSequence + '[' + indexInputValue + ']';
      }
    }
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
