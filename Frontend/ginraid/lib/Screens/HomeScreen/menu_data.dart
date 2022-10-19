// To parse this JSON data, do
//
//     final menuAll = menuAllFromJson(jsonString);

import 'dart:convert';

List<MenuAll> menuAllFromJson(String str) =>
    List<MenuAll>.from(json.decode(str).map((x) => MenuAll.fromJson(x)));

String menuAllToJson(List<MenuAll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuAll {
  MenuAll({
    required this.id,
    required this.owner,
    required this.ownerName,
    required this.ownerPic,
    required this.isFollowing,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isFavorites,
    required this.favoritesCount,
    required this.created,
  });

  int id;
  int owner;
  String ownerName;
  String ownerPic;
  bool isFollowing;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isFavorites;
  int favoritesCount;
  DateTime created;

  factory MenuAll.fromJson(Map<String, dynamic> json) => MenuAll(
        id: json["id"],
        owner: json["Owner"],
        ownerName: json["owner_name"],
        ownerPic: json["owner_pic"] == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : json["owner_pic"],
        isFollowing: json["is_following"],
        foodname: json["Foodname"],
        foodpic: json["Foodpic"] == null
            ? 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000'
            : json["Foodpic"],
        ingredient: json["ingredient"],
        recipes: json["recipes"],
        isFavorites: json["is_favorites"],
        favoritesCount: json["favorites_count"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Owner": owner,
        "owner_name": ownerName,
        "owner_pic": ownerPic == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : ownerPic,
        "is_following": isFollowing,
        "Foodname": foodname,
        "Foodpic": foodpic == null
            ? 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000'
            : foodpic,
        "ingredient": ingredient,
        "recipes": recipes,
        "is_favorites": isFavorites,
        "favorites_count": favoritesCount,
        "created": created.toIso8601String(),
      };
}
