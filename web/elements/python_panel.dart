import 'package:polymer/polymer.dart';


@CustomTag('python-panel')
class PythonPanel extends PolymerElement {

  @published String command;

  PythonPanel.created() : super.created();

}