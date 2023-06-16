// To parse this JSON data, do
//
//     final categorieModel = categorieModelFromJson(jsonString);

import 'dart:convert';

CategorieModel categorieModelFromJson(String str) => CategorieModel.fromJson(json.decode(str));

String categorieModelToJson(CategorieModel data) => json.encode(data.toJson());

class CategorieModel {
  int? id;
  String category_name;
  String? image;

  CategorieModel({
    this.id,
    required this.category_name,
    this.image,
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) => CategorieModel(
    id: json["id"],
    category_name: json["category_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": category_name,
    "image": image,
  };
}
