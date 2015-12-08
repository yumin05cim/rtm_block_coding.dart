import 'package:polymer/polymer.dart';


@CustomTag('block-editor')
class BlockEditor extends PolymerElement {

  @published String command;

  BlockEditor.created() : super.created();

}