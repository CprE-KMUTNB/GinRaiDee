// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
    Register({
        this.email,
        this.username,
        this.password,
        this.confirmPassword,
    });

    String? email;
    String? username;
    String? password;
    String? confirmPassword;

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        email: json["email"],
        username: json["username"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "password": password,
        "confirm_password": confirmPassword,
    };

    
}