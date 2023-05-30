// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? name;
  String? email;
  String? image;
  String? telephone;
  DateTime? dateCreated;
  DateTime? dateUpdate;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.telephone,
    this.dateCreated,
    this.dateUpdate,
  });

  factory UserModel.fromJson(Map json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    telephone: json["telephone"],
    dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
    dateUpdate: json["date_update"] == null ? null : DateTime.parse(json["date_update"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "telephone": telephone,
    "date_created": "${dateCreated!.year.toString().padLeft(4, '0')}-${dateCreated!.month.toString().padLeft(2, '0')}-${dateCreated!.day.toString().padLeft(2, '0')}",
    "date_update": "${dateUpdate!.year.toString().padLeft(4, '0')}-${dateUpdate!.month.toString().padLeft(2, '0')}-${dateUpdate!.day.toString().padLeft(2, '0')}",
  };
}
