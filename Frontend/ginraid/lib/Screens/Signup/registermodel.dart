// To parse this JSON data, do
//
//     final registermodel = registermodelFromJson(jsonString);

import 'dart:convert';

Registermodel registermodelFromJson(String str) =>
    Registermodel.fromJson(json.decode(str));

String registermodelToJson(Registermodel data) => json.encode(data.toJson());

class Registermodel {
  Registermodel({
    this.email,
    this.username,
    this.password,
    this.confirmPassword,
  });

  List<String>? email;
  List<String>? username;
  List<String>? password;
  List<String>? confirmPassword;

  factory Registermodel.fromJson(Map<String, dynamic> json) => Registermodel(
        email: json["email"] != null
            ? List<String>.from(json["email"].map((x) => x))
            : [],
        username: json["username"] != null
            ? List<String>.from(json["username"].map((x) => x))
            : [],
        password: json["password"] != null
            ? List<String>.from(json["password"].map((x) => x))
            : [],
        confirmPassword: json["confirm_password"] != null
            ? List<String>.from(json["confirm_password"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "email": email != null ? List<dynamic>.from(email!.map((x) => x)) : [],
        "username":
            username != null ? List<dynamic>.from(username!.map((x) => x)) : [],
        "password":
            password != null ? List<dynamic>.from(password!.map((x) => x)) : [],
        "confirm_password": confirmPassword != null
            ? List<dynamic>.from(confirmPassword!.map((x) => x))
            : [],
      };
}
