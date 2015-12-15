import 'dart:core';
import 'dart:async';
import 'package:rtm_block_coding/xmlrpc.dart' as rpc;

void main() {
  var base = new rpc.RPCBase();
  base.echo('hoge')
  .then((var out) {
    print(out);
  });
  var code = """
while True:
  print "Hello World"
  """;
  String f;
  var future = base.sendCode()
    ..then((var fn) {
    f = fn;
    print (fn);
    })
    ..catchError( (var e) {
      print(e);
    });

  Future.wait([future])
  .then((var es) {
    base.startCode(f)
    .then( (var n) {

      for(int i = 0;i < 10;i++) {
        base.stdout(n)
            .then((var outputs) {
          print(outputs);
        })
            .catchError((var e) {
          print(e);
        });
      }
    });
  }
  );
}