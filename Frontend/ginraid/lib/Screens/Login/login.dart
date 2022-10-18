import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://ginraid.herokuapp.com/user-api';

class Login {
  Client client = http.Client();
  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _userdata = json.encode(object);
    var _headers = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _userdata, headers: _headers);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 400) {
      return response;
    } else {
      print('fail');
      //throw exception and catch it in UI
    }
  }
}
