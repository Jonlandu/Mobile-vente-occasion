// To parse this JSON data, do
//
//     final tagModel = tagModelFromJson(jsonString);

import 'dart:convert';

TagModel tagModelFromJson(String str) => TagModel.fromJson(json.decode(str));

String tagModelToJson(TagModel data) => json.encode(data.toJson());

class TagModel {
  int? id;
  String? nom;

  TagModel({
    this.id,
    this.nom,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
    id: json["id"],
    nom: json["nom"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom": nom,
  };
}
