library xmlrpc.base;

import 'dart:async';
import 'package:xml_rpc/client.dart' as xmlrpc;
import 'package:http/http.dart' as http;
//import 'package:http/browser_client.dart';

class RPCBase {
  String _url = "RPC";
  http.Client _client = null;
  RPCBase({String url:'http://localhost:8080/RPC', http.Client client:null}) {
    this._url = url;
    this._client = client;
  }

  Future<dynamic> rpc(String signature, var argument) {
    return xmlrpc.call(_url, signature, argument, client: _client,
        headers: {'Access-Control-Allow-Origin' : 'http://localhost',
          'Access-Control-Allow-Methods' : 'GET, POST',
          'Access-Control-Allow-Headers' : 'x-prototype-version,x-requested-with'});
  }


  Future<dynamic> echo(var output) {
    return rpc('echo', [output]);
  }

  Future<String> sendCode(String code) {
    return rpc('sendCode', [code]);
  }

  Future<bool> startCode(String filename) {
    return rpc('startCode', [filename]);
  }

  Future<String> stdout(int num) {
    return rpc('stdout', [num]);
  }

  Future<String> communicate(int num) {
    return rpc('communicate', [num]);
  }

}

