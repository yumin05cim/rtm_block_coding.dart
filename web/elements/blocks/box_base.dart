import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';

@CustomTag('add-port')
class BoxBase extends PolymerElement {
  var _model;

  set model(var m) {
    _model = m;
  }

  get model => _model;

  BoxBase.created() : super.created();

}