import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String baseUrl = 'https://ginraid.herokuapp.com/user-api';

class RegisterService {
  var client = http.Client();

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Accept' : 'application/json',
      
      'Content-Type': 'application/json',
    };

    var response = await client.post(url,  headers: _headers,body: _payload,);

    if (response.statusCode == 201) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }
}


//get

//   var client = http.Client();

//   Future<dynamic> get(String api) async{
//     var
//   }
// }





