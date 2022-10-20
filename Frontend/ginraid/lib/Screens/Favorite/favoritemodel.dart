// To parse this JSON data, do
//
//     final favorite = favoriteFromJson(jsonString);

import 'dart:convert';

List<Favorite> favoriteFromJson(String str) =>
    List<Favorite>.from(json.decode(str).map((x) => Favorite.fromJson(x)));

String favoriteToJson(List<Favorite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorite {
  Favorite({
    required this.favMenu,
    required this.user,
    required this.ownerId,
    required this.ownerName,
    required this.ownerPic,
    required this.foodname,
    required this.ingredient,
    required this.recipes,
    required this.foodpic,
    required this.isFollowing,
    required this.isFavorites,
    required this.favoritesCount,
    required this.created,
  });

  int favMenu;
  int user;
  int ownerId;
  String ownerName;
  String ownerPic;
  String foodname;
  String ingredient;
  String recipes;
  String foodpic;
  bool isFollowing;
  bool isFavorites;
  int favoritesCount;
  DateTime created;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        favMenu: json["fav_menu"],
        user: json["user"],
        ownerId: json["owner_id"],
        ownerName: json["owner_name"],
        ownerPic: json["owner_pic"] == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : json["owner_pic"],
        foodname: json["Foodname"],
        ingredient: json["ingredient"],
        recipes: json["recipes"],
        foodpic: json["Foodpic"] == null
            ? 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000'
            : json["Foodpic"],
        isFollowing: json["is_following"],
        isFavorites: json["is_favorites"],
        favoritesCount: json["favorites_count"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "fav_menu": favMenu,
        "user": user,
        "owner_id": ownerId,
        "owner_name": ownerName,
        "owner_pic": ownerPic == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : ownerPic,
        "Foodname": foodname,
        "ingredient": ingredient,
        "recipes": recipes,
        "Foodpic": foodpic == null
            ? 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000'
            : foodpic,
        "is_following": isFollowing,
        "is_favorites": isFavorites,
        "favorites_count": favoritesCount,
        "created": created.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final follow = followFromJson(jsonString);

List<Follow> followFromJson(String str) =>
    List<Follow>.from(json.decode(str).map((x) => Follow.fromJson(x)));

String followToJson(List<Follow> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Follow {
  Follow({
    required this.following,
    required this.followingname,
    required this.followingpic,
    required this.created,
  });

  int following;
  String followingname;
  String followingpic;
  DateTime created;

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
        following: json["following"],
        followingname: json["followingname"],
        followingpic: json["followingpic"] == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : json["followingpic"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "following": following,
        "followingname": followingname,
        "followingpic": followingpic == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : followingpic,
        "created": created.toIso8601String(),
      };
}
