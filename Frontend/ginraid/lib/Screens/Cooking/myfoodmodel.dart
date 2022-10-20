// To parse this JSON data, do
//
//     final selfmenu = selfmenuFromJson(jsonString);

import 'dart:convert';

List<Selfmenu> selfmenuFromJson(String str) =>
    List<Selfmenu>.from(json.decode(str).map((x) => Selfmenu.fromJson(x)));

String selfmenuToJson(List<Selfmenu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Selfmenu {
  Selfmenu({
    this.id,
    this.owner,
    this.ownerName,
    this.ownerPic,
    this.isFollowing,
    this.foodname,
    this.foodpic,
    this.ingredient,
    this.recipes,
    this.isFavorites,
    this.favoritesCount,
    this.isPublic,
    this.created,
  });

  int? id;
  int? owner;
  String? ownerName;
  String? ownerPic;
  bool? isFollowing;
  String? foodname;
  String? foodpic;
  String? ingredient;
  String? recipes;
  bool? isFavorites;
  int? favoritesCount;
  bool? isPublic;
  DateTime? created;

  factory Selfmenu.fromJson(Map<String, dynamic> json) => Selfmenu(
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
        isPublic: json["is_public"],
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
        "is_public": isPublic,
        "created": created!.toIso8601String(),
      };
}
