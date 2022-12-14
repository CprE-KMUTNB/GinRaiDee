import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

class Cooking {
  Client client = http.Client();
  Future<dynamic> get() async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/menu-api/self/?ordering=-created');
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

  Future<dynamic> search(String data) async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/menu-api/self/?search=${data}');
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

  Future<dynamic> post(String foodname, String ingredient, String recipe,
      bool isPublic, dynamic picture) async {
    var url = Uri.parse('https://ginraid.herokuapp.com/menu-api/self/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(_headers);
    request.fields["Foodname"] = foodname;
    request.fields["ingredient"] = ingredient;
    request.fields["recipes"] = recipe;
    request.fields["is_public"] = isPublic.toString();
    request.files.add(await http.MultipartFile.fromPath("Foodpic", picture));
    var response = await request.send();
    if (response.statusCode == 201) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
      return response;
    } else {
      print('fail');
      return response;
    }
  }

  Future<dynamic> getbeforepost(int id) async {
    var url = Uri.parse('https://ginraid.herokuapp.com/menu-api/self/$id/');
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

  Future<dynamic> put(int id, dynamic data) async {
    var url = Uri.parse('https://ginraid.herokuapp.com/menu-api/self/$id/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var _body = json.encode(data);
    var response = await client.put(url, headers: _headers, body: _body);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
      return response;
    }
  }

  Future<dynamic> putimage(int id, dynamic data) async {
    var url = Uri.parse('https://ginraid.herokuapp.com/menu-api/pic/$id/');
    var _headers = {
      'Authorization': 'Token ${await getToken()}',
    };
    var request = http.MultipartRequest('PUT', url);
    request.headers.addAll(_headers);
    request.files.add(await http.MultipartFile.fromPath("Foodpic", data));
    var response = await request.send();
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
      return response;
    }
  }

  Future<dynamic> delete(int id) async {
    var url = Uri.parse('https://ginraid.herokuapp.com/menu-api/self/$id/');
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
    }
  }
}
