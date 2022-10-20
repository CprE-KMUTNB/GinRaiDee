// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<Notificationmodel> notificationmodelFromJson(String str) =>
    List<Notificationmodel>.from(
        json.decode(str).map((x) => Notificationmodel.fromJson(x)));

String notificationmodelToJson(List<Notificationmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notificationmodel {
  Notificationmodel({
    required this.id,
    required this.sender,
    required this.senderName,
    required this.senderPic,
    required this.receiver,
    required this.receiverName,
    required this.information,
    required this.foodname,
    required this.ingredient,
    required this.recipes,
    required this.foodpic,
    required this.created,
    required this.isFollowing,
    required this.isFavorites,
    required this.favoritesCount,
    required this.haveRead,
  });

  int id;
  int sender;
  String senderName;
  dynamic senderPic;
  int receiver;
  String receiverName;
  int information;
  String foodname;
  String ingredient;
  String recipes;
  String foodpic;
  DateTime created;
  bool isFollowing;
  bool isFavorites;
  int favoritesCount;
  bool haveRead;

  factory Notificationmodel.fromJson(Map<String, dynamic> json) =>
      Notificationmodel(
        id: json["id"],
        sender: json["Sender"],
        senderName: json["sender_name"],
        senderPic: json["sender_pic"] == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : json["sender_pic"],
        receiver: json["Receiver"],
        receiverName: json["receiver_name"],
        information: json["Information"],
        foodname: json["Foodname"],
        ingredient: json["ingredient"],
        recipes: json["recipes"],
        foodpic: json["Foodpic"] == null
            ? 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000'
            : json["Foodpic"],
        created: DateTime.parse(json["created"]),
        isFollowing: json["is_following"],
        isFavorites: json["is_favorites"],
        favoritesCount: json["favorites_count"],
        haveRead: json["have_read"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Sender": sender,
        "sender_name": senderName,
        "sender_pic": senderPic == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : senderPic,
        "Receiver": receiver,
        "receiver_name": receiverName,
        "Information": information,
        "Foodname": foodname,
        "ingredient": ingredient,
        "recipes": recipes,
        "Foodpic": foodpic == null
            ? 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000'
            : foodpic,
        "created": created.toIso8601String(),
        "is_following": isFollowing,
        "is_favorites": isFavorites,
        "favorites_count": favoritesCount,
        "have_read": haveRead,
      };
}
