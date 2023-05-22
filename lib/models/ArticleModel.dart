// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

ArticleModel articleModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  int? id;
  String? title;
  String? keyword;
  int? interrese;
  String? categorie;
  String? country;
  String? city;
  int? price;
  String? negociation;
  String? image;
  String? content;
  String? annoncesSimilaires;
  DateTime? createdAt;
  DateTime? updatedAt;

  ArticleModel({
    this.id,
    this.title,
    this.keyword,
    this.interrese,
    this.categorie,
    this.country,
    this.city,
    this.price,
    this.negociation,
    this.image,
    this.content,
    this.annoncesSimilaires,
    this.createdAt,
    this.updatedAt,
  });

  factory ArticleModel.fromJson(Map json) => ArticleModel(
    id: json["id"],
    title: json["title"],
    keyword: json["keyword"],
    interrese : json["interrese"],
    categorie: json["categorie"],
    country: json["country"],
    city: json["city"],
    price: json["price"],
    negociation: json["negociation"],
    image: json["image"],
    content: json["content"],
    annoncesSimilaires: json["annonces_similaires"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "keyword": keyword,
    "interrese": interrese,
    "categorie": categorie,
    "country": country,
    "city": city,
    "price": price,
    "negociation" : negociation,
    "image": image,
    "content": content,
    "annonces_similaires": annoncesSimilaires,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}
