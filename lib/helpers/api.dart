import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class Api {
  Future<Response>get(String url)
  async {

var response = await http.get(Uri.parse(url));
if(kDebugMode){
  print("Get on$url");
  print("response${response.statusCode}");

  print("response${response.body}");

}
return response;

}
  }