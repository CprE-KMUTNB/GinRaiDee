import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

class Favoritefood {
  Client client = http.Client();

  Future<dynamic> post(int menu_id) async {
    var url = Uri.parse('https://ginraid.herokuapp.com/menu-api/favorite/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var data = {"fav_menu": menu_id};
    var _body = json.encode(data);
    var response = await client.post(url, headers: _headers, body: _body);
    if (response.statusCode == 201) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
      return response;
    }
  }

  Future<dynamic> delete(int menu_id) async {
    var url =
        Uri.parse('https://ginraid.herokuapp.com/menu-api/fav-list/$menu_id/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 204) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
      return response;
    }
  }
}
