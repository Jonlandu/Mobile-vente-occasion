// To parse this JSON data, do
//
//     final conversationModel = conversationModelFromJson(jsonString);

import 'dart:convert';

ConversationModel conversationModelFromJson(String str) => ConversationModel.fromJson(json.decode(str));

String conversationModelToJson(ConversationModel data) => json.encode(data.toJson());

class ConversationModel {
  int? id;
  int? articleId;
  String? articleTitle;
  String? date;
  List<Client>? clients;

  ConversationModel({
    this.id,
    this.articleId,
    this.articleTitle,
    this.date,
    this.clients,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json["id"],
    articleId: json["article_id"],
    articleTitle: json["article_title"],
    date: json["date"],
    clients: json["clients"] == null ? [] : List<Client>.from(json["clients"]!.map((x) => Client.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "article_id": articleId,
    "article_title": articleTitle,
    "date": date,
    "clients": clients == null ? [] : List<dynamic>.from(clients!.map((x) => x.toJson())),
  };
}

class Client {
  int? id;
  String? nom;

  Client({
    this.id,
    this.nom,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    nom: json["nom"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom": nom,
  };
}
