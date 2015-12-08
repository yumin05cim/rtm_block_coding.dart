import 'package:program_model/application.dart' as program;
import 'package:connection_model/connection.dart' as connect;
import '../elements/editor_panel.dart';

class Controller {

  connect.Application onActivatedApp = new connect.Application();
  connect.Application onExecuteApp = new connect.Application();
  connect.Application onDeactivatedApp = new connect.Application();
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

  connect.Statement selectedStatement() {
    return null;
  }

  void addElement(String command) {
    print('add ${command}');
    connect.Application app;
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
        connect.Statement s = last(app);
        connect.Statement new_s = new connect.Statement();
        connect.SetVariable v = new connect.SetVariable(new_s, 'name');
        connect.IntegerLiteral il = new connect.IntegerLiteral(new_s, 1);
        il.out.connect(v.in0);
        s.next.connect(new_s.previous);
      }
    }

    _editorPanel.refresh(app);
  }

  set editorPanel(EditorPanel p) => _editorPanel = p;
}