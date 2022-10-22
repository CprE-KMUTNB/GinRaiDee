import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

Future<dynamic> setUsername(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('username', value);
}

Future<String> getUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String username = await prefs.getString('username').toString();
  return username;
}

Future<int> getID() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int userID = await prefs.getInt('user_id')!;
  return userID;
}

Future<dynamic> delete() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_id');
  await prefs.remove('username');
  await prefs.remove('token');
}

class Userdata {
  Client client = http.Client();
  Future<dynamic> get() async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/user-api/all-data/${await getID()}/');
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

  Future<dynamic> changeusername(String username) async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/user-api/username/${await getID()}/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var data = {"username": username};
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

  Future<dynamic> putimage(dynamic picture) async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/user-api/picture/${await getID()}/');
    var _headers = {
      'Authorization': 'Token ${await getToken()}',
    };
    var request = http.MultipartRequest('PUT', url);
    request.headers.addAll(_headers);
    request.files.add(await http.MultipartFile.fromPath("userpic", picture));
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

  Future<dynamic> deleteimage() async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/user-api/picture/${await getID()}/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var data = {"userpic": null};
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

  Future<dynamic> changepassword(dynamic data) async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/user-api/password/${await getID()}/');
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
    }
    if (response.statusCode == 400) {
      print('password error');
      return response;
    } else {
      print('fail');
    }
  }

  Future<dynamic> deleteaccount() async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/user-api/all-data/${await getID()}/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var response = await client.delete(url, headers: _headers);
    await delete();
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
