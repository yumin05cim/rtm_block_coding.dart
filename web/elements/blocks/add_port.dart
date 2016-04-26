import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'box_base.dart';
import 'package:paper_elements/paper_item.dart';
import 'package:paper_elements/paper_dropdown_menu.dart';

@CustomTag('add-port')
class AddPortBox extends BoxBase {
  set model(program.AddPort m) {
    super.model = m;
    port_name = m.name;
    port_type = m.dataType.typename;
  }

  @published String port_name = "defaultName";
  @published String port_type = "defaultType";
  AddPortBox.created() : super.created();


}