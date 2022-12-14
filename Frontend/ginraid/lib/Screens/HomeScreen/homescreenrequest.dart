import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'https://ginraid.herokuapp.com/menu-api/all/';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

class Allmenu {
  Client client = http.Client();
  Future<dynamic> get(String search) async {
    var url = Uri.parse(baseUrl + search);
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
    }
  }
}

class Userviewmenu {
  Client client = http.Client();
  Future<dynamic> get(int user) async {
    var url =
        Uri.parse('https://ginraid.herokuapp.com/user-api/all-data/$user/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
    }
  }
}

class Report {
  Client client = http.Client();
  Future<dynamic> post(String text, int menu) async {
    var url = Uri.parse('https://ginraid.herokuapp.com/report-api/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var data = {"report_text": text, "target_object": menu};

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
}
