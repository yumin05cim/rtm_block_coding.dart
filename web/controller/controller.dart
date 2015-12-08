import '../elements/editor_panel.dart';
import '../../lib/application.dart' as program;
class Controller {

  program.Application onActivatedApp = new program.Application();
  program.Application onExecuteApp = new program.Application();
  program.Application onDeactivatedApp = new program.Application();
  EditorPanel _editorPanel;

  Controller() {

  }


  String getSelectedEditorPanelName() {
    switch(_editorPanel.selected) {
      case 0:
        return 'onActivated';
      case 1:
        return 'onExecute';
      case 2:
        return 'onDeactivated';
      default:
        return null;
    }
  }

  connect.Statement last(connect.Application app){
    connect.Statement s = app.startState;
    while(true) {
      if(s.next.connections.length > 0) {
        if(s.next == s.next.connections[0].ports[0]) {
          s = s.next.connections[0].ports[1].owner;
        } else {
          s = s.next.connections[0].ports[0].owner;
        }
      } else {
        return s;
      }
    }
  }

  program.Statement selectedStatement() {
    return null;
  }

  void addElement(String command) {
    print('add ${command}');
    program.Application app;
    switch (_editorPanel.selected) {
      case 0:
        app = onActivatedApp;
        break;
      case 1:
        app = onExecuteApp;
        break;
      case 2:
        app = onDeactivatedApp;
        break;
    }

    if (command == 'set_variable') {
      if (selectedStatement() == null) {
        program.SetValue v = new program.SetValue(new program.Variable('name'),
                    new program.Integer(1));
        program.Statement new_s = new program.Statement(v);
        app.statements.add(new_s);
      }
    }

    _editorPanel.refresh(app);
  }

  set editorPanel(EditorPanel p) => _editorPanel = p;


  String pythonCode() {
    var a = onActivatedApp.toPython(1);

    var e = onExecuteApp.toPython(1);

    var d = onDeactivatedApp.toPython(1);
    return """
def onActivated(e):
$a
  return RTC.RTC_OK


def onDeactivated(e):
$d
  return RTC.RTC_OK


def onExecute(e):
$e
  return RTC.RTC_OK
    """;
  }
}