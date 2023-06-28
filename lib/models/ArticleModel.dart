// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

ArticleModel articleModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  int? id;
  int? user_id;
  String? user_name;
  String? title;
  String? keyword;
  int? interesse;
  int? views;
  String? categorie_name;
  int? categorie_id;
  String? country;
  String? city;
  int? price;
  String? devise;
  int? negociation;
  List<ImageArticle> images;
  String? content;
  String? abus_id;
  DateTime? createdAt;

  ArticleModel({
    this.id,
    this.user_id,
    this.user_name,
    this.title,
    this.keyword,
    this.interesse,
    this.views,
    this.categorie_name,
    this.categorie_id,
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
    user_name : json["user_name"],
    title: json["title"],
    keyword: json["keyword"],
    interesse : json["like_count"],
    views : json["vues_count"],
    categorie_name: json["category_name"],
    categorie_id: json["category_id"],
    country: json["country"],
    city: json["city"],
    price: json["price"],
    devise: json["devise"],
    negociation: json["negociation"],
    images: json["images"] == null ? [] : List<ImageArticle>.from(json["images"]!.map((x) => ImageArticle.fromJson(x))),
    content: json["content"],
    abus_id: json["abus_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id" : user_id,
    "user_name" : user_name,
    "title": title,
    "keyword": keyword,
    "like_count": interesse,
    "vues_count" : views,
    "category_name": categorie_name,
    "category_id": categorie_id,
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

class ImageArticle {
  int? id;
  int? articleId;
  String? imagePath;
  int? active;

  ImageArticle({
    this.id,
    this.articleId,
    this.imagePath,
    this.active,
  });

  factory ImageArticle.fromJson(Map<String, dynamic> json) => ImageArticle(
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
