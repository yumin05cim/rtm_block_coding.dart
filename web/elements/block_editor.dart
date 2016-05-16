import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:rtm_block_coding/application.dart' as program;
import '../controller/controller.dart';
import 'block_parser.dart';

@CustomTag('block-editor')
class BlockEditor extends PolymerElement {

  @published String command;

  BlockEditor.created() : super.created();

  /*
  var up_offset = [-20, 100];
  var down_offset = [-20, 180];
  var delete_offset = [-20, 260];
  */

  get container => $['container'];

  @override
  void attached() {
  }

  void onClicked(var e) {
    globalController.setSelectedElem(e, globalController.selectedElement);
    e.stopPropagation();
  }

  /*
  void updateClick() {
    if (globalController.selectedElement == null) {
      $['up'].style.display = 'none';
      $['down'].style.display = 'none';
      $['delete'].style.display = 'none';

    } else {
      $['up'].style.display = 'inline';
      $['down'].style.display = 'inline';
      $['delete'].style.display = 'inline';
      var height = (globalController.selectedElement as html.HtmlElement).clientHeight;
      if (height == 0) {
        (globalController.selectedElement as PolymerElement).shadowRoot.children.forEach(
            (var e) {
              if (e is html.StyleElement) {
              } else {
                height = e.offset.height;
              }
            }
        );
      }

      var top = globalController.selectedElement.offset.top + height;
      var left = globalController.selectedElement.offset.left;
      $['up'].style.top = '${top + up_offset[0]}px';
      $['up'].style.left = '${left + up_offset[1]}px';

      $['down'].style.top = '${top + down_offset[0]}px';
      $['down'].style.left = '${left + down_offset[1]}px';

      $['delete'].style.top = '${top + delete_offset[0]}px';
      $['delete'].style.left = '${left + delete_offset[1]}px';
    }
  }
  */

  void refresh(program.Application app) {
    container.children.clear();
    app.statements.forEach((s) {
      BlockParser.parseStatement(container.children, s);
    });
  }

  void delete(program.StatementList slist, var elem) {
    var stat = null;
    slist.forEach(
        (var s) {
      if (s.block == elem.model) {
        stat = s;
      }
    }
    );
    if (stat != null) {
      slist.remove(stat);
    }
  }

  void onUp(var e) {
    var selected = globalController.selectedElement;
    if (selected == null) return;

    program.Statement s = selected.model.parent;
    if (s != null) {
      program.StatementList sl = s.parent;
      if (sl != null) {
        var index = sl.indexOf(s);
        index--;
        if (index >= 0) {
          sl.remove(s);
          sl.insert(index, s);

          globalController.setSelectedElem(globalController.previousMouseEvent, selected);
          globalController.refreshPanel();
          //updateClick();
        }
      }
    }
  }

  void onDown(var e) {
    var selected = globalController.selectedElement;
    if (selected == null) return;

    program.Statement s = selected.model.parent;
    if (s != null) {
      program.StatementList sl = s.parent;
      if (sl != null) {
        var index = sl.indexOf(s);
        index++;
        if (index < sl.length) {
          sl.remove(s);
          sl.insert(index, s);

          globalController.setSelectedElem(globalController.previousMouseEvent, selected);
          globalController.refreshPanel();
          //updateClick();
        }
      }
    }
  }

  void onRemove(var e) {
    var selected = globalController.selectedElement;
    if (selected == null) return;

    if (selected.parent == container) {
      var app = globalController.getSelectedEditorApplication();
      delete(app.statements, selected);
    }
    globalController.setSelectedElem(globalController.previousMouseEvent, null);
    globalController.refreshPanel();

    //updateClick();

  }

}