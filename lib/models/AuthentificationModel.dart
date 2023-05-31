// To parse this JSON data, do
//
//     final authentificationModel = authentificationModelFromJson(jsonString);

import 'dart:convert';

AuthentificationModel authentificationModelFromJson(String str) => AuthentificationModel.fromJson(json.decode(str));

String authentificationModelToJson(AuthentificationModel data) => json.encode(data.toJson());

class AuthentificationModel {
  int? id;
  String? email;
  String? token;

  AuthentificationModel({
    this.id,
    this.email,
    this.token,
  });

  factory AuthentificationModel.fromJson(Map json) => AuthentificationModel(
    id: json["id"],
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "token": token,
  };
}
