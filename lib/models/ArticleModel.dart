// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

ArticleModel articleModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  int? id;
  int? user_id;
  String? title;
  String? keyword;
  int? interrese;
  int? views;
  String? categorie;
  String? country;
  String? city;
  int? price;
  String? devise;
  int? negociation;
  List<Image> images;
  String? content;
  String? abus_id;
  DateTime? createdAt;

  ArticleModel({
    this.id,
    this.user_id,
    this.title,
    this.keyword,
    this.interrese,
    this.views,
    this.categorie,
    this.country,
    this.city,
    this.price,
    this.devise,
    this.negociation,
    this.images=const [],
    this.content,
    this.abus_id,
    this.createdAt,
  });

  factory ArticleModel.fromJson(Map json) => ArticleModel(
    id: json["id"],
    user_id : json["user_id"],
    title: json["title"],
    keyword: json["keyword"],
    interrese : json["interrese"],
    views : json["views"],
    categorie: json["categorie"],
    country: json["country"],
    city: json["city"],
    price: json["price"],
    devise: json["devise"],
    negociation: json["negociation"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    content: json["content"],
    abus_id: json["abus_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id" : user_id,
    "title": title,
    "keyword": keyword,
    "interrese": interrese,
    "views" : views,
    "categorie": categorie,
    "country": country,
    "city": city,
    "price": price,
    "devise": devise,
    "negociation" : negociation,
    "images": images == "" ? [] : List<dynamic>.from(images.map((x) => x.toJson())),
    "content": content,
    "abus_id": abus_id,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Image {
  int? id;
  int? articleId;
  String? imagePath;
  int? active;

  Image({
    this.id,
    this.articleId,
    this.imagePath,
    this.active,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    articleId: json["article_id"],
    imagePath: json["image_path"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "article_id": articleId,
    "image_path": imagePath,
    "active": active,
  };
}
