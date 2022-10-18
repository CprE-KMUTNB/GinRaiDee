// To parse this JSON data, do
//
//     final loginmodel = loginmodelFromJson(jsonString);

import 'dart:convert';

Loginmodel loginmodelFromJson(String str) =>
    Loginmodel.fromJson(json.decode(str));

String loginmodelToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
  Loginmodel({
    this.email,
    this.password,
    this.error,
    this.token,
    this.userId,
    this.name,
  });

  List<String>? email;
  List<String>? password;
  List<String>? error;
  String? token;
  int? userId;
  String? name;

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        email: json["username"] != null
            ? List<String>.from(json["username"].map((x) => x))
            : [],
        password: json["password"] != null
            ? List<String>.from(json["password"].map((x) => x))
            : [],
        error: json["non_field_errors"] != null
            ? List<String>.from(json["non_field_errors"].map((x) => x))
            : [],
        token: json["token"],
        userId: json["user_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "username":
            email != null ? List<dynamic>.from(email!.map((x) => x)) : [],
        "password":
            password != null ? List<dynamic>.from(password!.map((x) => x)) : [],
        "non_field_errors":
            error != null ? List<dynamic>.from(error!.map((x) => x)) : [],
        "token": token,
        "user_id": userId,
        "name": name,
      };
}
